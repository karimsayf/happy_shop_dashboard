import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_toast.dart';
import '../utilities/colors.dart';
import '../view/main_screen/main_screen.dart';
import 'user_view_model.dart';

class AuthFormProvider extends ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = true;
  bool isLoading = false;
  bool isChecked = false;
  Color labelUserNameColor = AppColors.c912;
  Color labelPasswordColor = AppColors.c912;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FocusNode focusNodeFirst = FocusNode();
  final FocusNode focusNodeSecond = FocusNode();

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setChecked(bool value) {
    isChecked = value;
    notifyListeners();
  }

  void updateLabelUserNameColor(bool hasFocus) {
    labelUserNameColor = hasFocus ? AppColors.mainColor : AppColors.c912;
    notifyListeners();
  }

  void updateLabelPasswordColor(bool hasFocus) {
    labelPasswordColor = hasFocus ? AppColors.mainColor : AppColors.c912;
    notifyListeners();
  }

  void clearData() {
    usernameController.clear();
    passwordController.clear();
    isPasswordVisible = true;
    isLoading = false;
    isChecked = false;
    labelUserNameColor = AppColors.c912;
    labelPasswordColor = AppColors.c912;
    notifyListeners();
  }


  Future signIn(BuildContext context,String username, String password) async {
    if (formKey.currentState!.validate()) {
      setLoading(true);
      formKey.currentState!.save();
      await Provider.of<UserViewModel>(context, listen: false)
          .signIn(context, username, password)
          .then((signInResponse) async {
        if (signInResponse["status"] == "success") {
          print(signInResponse["data"]);
          await Provider.of<UserViewModel>(context, listen: false)
              .saveUserDataToFSS(
              signInResponse["data"]["token"] ?? "",
              signInResponse["data"]["user"]["_id"] ?? "",
              signInResponse["data"]["user"]["name"] ?? "")
              .then(
                (_) async {
              await Provider.of<UserViewModel>(context, listen: false)
                  .loadUserDataFromFSS()
                  .then(
                    (_) {
                  setLoading(false);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(),
                    ),
                        (route) => false,
                  );
                },
              );
            },
          );
        } else {
          setLoading(false);
          if (signInResponse["data"] is Map &&
              signInResponse["data"]["message"] != null) {
            showCustomToast(context, signInResponse["data"]["message"],
                "assets/icons/alert-circle.webp", AppColors.c999);
          } else {
            showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
                "assets/icons/alert-circle.webp", AppColors.c999);
          }
        }
      }).catchError((error) {
        if (error is DioException) {
          print('DioError in requestOrder: ${error.message}');
          setLoading(false);
          print("dio error");
          showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
              "assets/icons/alert-circle.webp", AppColors.c999);
        } else {
          // Handle other errors
          print('Error in requestOrder: $error');
          setLoading(false);
          print("error");
          showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
              "assets/icons/alert-circle.webp", AppColors.c999);
        }
      });
    }
  }



}