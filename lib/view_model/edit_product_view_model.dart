import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_toast.dart';
import '../model/product_model/product_model.dart';
import '../utilities/colors.dart';
import '../utilities/constants.dart';
import 'api_services_view_model.dart';
import 'general_view_model.dart';
import 'user_view_model.dart';

class EditProductViewModel with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController sectionName = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController components = TextEditingController();
  PlatformFile? file;
  bool loading = false;
  String? sectionId;
  String? photoNetwork;
  String? productId;

  clearData() {
    name.clear();
    file = null;
    sectionName.clear();
    sectionId = null;
    photoNetwork = null;
    price.clear();
    components.clear();
    productId = null;
    notifyListeners();
  }

  assignData(ProductModel product){
    name.text = product.name;
    sectionName.text = product.categoryName;
    photoNetwork = product.photo;
    sectionId = product.categoryId;
    components.text = product.components;
    productId = product.id;
    price.text = product.price;
    notifyListeners();
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  Future editProduct(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setLoading(true);
      Map<String,dynamic> body = {
        "name": name.text.trim(),
        "components": components.text,
        "price" : price.text.trim()
      };
      if(file != null){
        body.addAll({
          'photo':  MultipartFile.fromBytes(
              file!.bytes!,
              filename: file!.xFile.name
          ),
        });
      }
      formKey.currentState!.save();
      await Provider.of<ApiServicesViewModel>(context, listen: false)
          .updateData(
        apiUrl: "$baseUrl/api/product/$sectionId/$productId",
        headers: {
          'Authorization':
          'Bearer ${Provider.of<UserViewModel>(context, listen: false).userToken}'
        },
        formData: FormData.fromMap(body),)
          .then((getSubsectionsResponse) {
        print(getSubsectionsResponse);
        if (getSubsectionsResponse["status"] == "success") {
          loading = false;
          showCustomToast(context, "تم تعديل المنتج بنجاح",
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