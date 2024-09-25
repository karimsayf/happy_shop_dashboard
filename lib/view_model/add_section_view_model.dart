import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_toast.dart';
import '../utilities/colors.dart';
import '../utilities/constants.dart';
import 'api_services_view_model.dart';
import 'general_view_model.dart';
import 'user_view_model.dart';

class AddSectionViewModel with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  PlatformFile? file;
  bool loading = false;

  clearData() {
    name.clear();
    file = null;
    notifyListeners();
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  Future addSection(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setLoading(true);
      formKey.currentState!.save();
      await Provider.of<ApiServicesViewModel>(context, listen: false)
          .postData(
              apiUrl: "$baseUrl/api/v1/category",
              headers: {
                'Authorization':
                    Provider.of<UserViewModel>(context, listen: false).userToken
              },
              data: {
                "name": name.text.trim(),
                /*"photo": MultipartFile.fromBytes(file!.bytes!,
                    filename: file!.xFile.name),*/
              "photo" : "test"
              })
          .then((getSubsectionsResponse) {
        print(getSubsectionsResponse);
        if (getSubsectionsResponse["status"] == "success") {
          loading = false;
          showCustomToast(context, "تم اضافة القسم بنجاح",
              "assets/icons/check_c.webp", AppColors.c368);
          Provider.of<GeneralViewModel>(context, listen: false)
              .updateSelectedIndex(index: SECTIONS_INDEX);
          notifyListeners();
        } else {
          setLoading(false);
          if (getSubsectionsResponse["data"] is Map &&
              getSubsectionsResponse["data"]["message"] != null) {
            showCustomToast(context, getSubsectionsResponse["data"]["message"],
                "assets/icons/alert-circle.webp", AppColors.c999);
          } else {
            print(getSubsectionsResponse["data"]);
            showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
                "assets/icons/alert-circle.webp", AppColors.c999);
          }
        }
      }).catchError((error) {
        if (error is DioException) {
          setLoading(false);
          print('DioError in requestOrder: ${error.message}');
          showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
              "assets/icons/alert-circle.webp", AppColors.c999);
        } else {
          setLoading(false);
          // Handle other errors
          print('Error in requestOrder: $error');
          showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
              "assets/icons/alert-circle.webp", AppColors.c999);
        }
      });
    }
  }
}
