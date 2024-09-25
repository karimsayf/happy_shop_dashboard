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

class AddProductViewModel with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController sectionName = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController components = TextEditingController();
  PlatformFile? file;
  bool loading = false;
  String? sectionId;

  clearData() {
    name.clear();
    file = null;
    sectionName.clear();
    sectionId = null;
    price.clear();
    components.clear();
    notifyListeners();
  }

  void setLoading (bool value) {
    loading = value;
    notifyListeners();
  }

  assignData(String section, String id){
    sectionName.text = section;
    sectionId = id;
    notifyListeners();
  }

  Future addProduct(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setLoading(true);
      formKey.currentState!.save();
      await Provider.of<ApiServicesViewModel>(context, listen: false)
          .postData(
          apiUrl: "$baseUrl/api/v1/product",
          headers: {
            'Authorization':
            Provider.of<UserViewModel>(context, listen: false).userToken
          },
          data: {
            "name": name.text.trim(),
            /*"photo": MultipartFile.fromBytes(file!.bytes!,
                filename: file!.xFile.name),*/
            "photo" : "test",
            "component": components.text.trim(),
            "price" : price.text.trim(),
            "categoryId" : sectionId,
          })
          .then((getSubsectionsResponse) {
        print(getSubsectionsResponse);
        if (getSubsectionsResponse["status"] == "success") {
          loading = false;
          showCustomToast(context, "تم اضافة المنتج بنجاح",
              "assets/icons/check_c.webp", AppColors.c368);
          Provider.of<GeneralViewModel>(context, listen: false)
              .updateSelectedIndex(index: PRODUCTS_INDEX);
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
        setLoading(false);
        if (error is DioException) {
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