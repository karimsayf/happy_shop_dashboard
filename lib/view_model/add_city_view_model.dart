import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_toast.dart';
import '../utilities/colors.dart';
import '../utilities/constants.dart';
import 'api_services_view_model.dart';
import 'general_view_model.dart';
import 'user_view_model.dart';

class AddCityViewModel extends ChangeNotifier{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController price = TextEditingController();
  bool loading = false;


  clearData(){
    name.clear();
    price.clear();
    notifyListeners();
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  Future addCity(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setLoading(true);
      formKey.currentState!.save();
      await Provider.of<ApiServicesViewModel>(context, listen: false)
          .postData(
          apiUrl: "$baseUrl/api/v1/city",
          headers: {
            'Authorization':
            Provider.of<UserViewModel>(context, listen: false).userToken
          },
          data:{
            "name": name.text.trim(),
            "price": price.text.trim(),
          })
          .then((addEmployeeResponse) {
        print(addEmployeeResponse);
        if (addEmployeeResponse["status"] == "success") {
          loading = false;
          showCustomToast(context, "تمت إضافة مدينة بنجاح",
              "assets/icons/check_c.webp", AppColors.c368);
          Provider.of<GeneralViewModel>(context, listen: false)
              .updateSelectedIndex(index: CITY_INDEX);
          notifyListeners();
        } else {
          setLoading(false);
          if (addEmployeeResponse["data"] is Map &&
              addEmployeeResponse["data"]["message"] != null) {
            showCustomToast(context, addEmployeeResponse["data"]["message"],
                "assets/icons/alert-circle.webp", AppColors.c999);
          } else {
            print(addEmployeeResponse["data"]);
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