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
  final TextEditingController finalPrice = TextEditingController();
  final TextEditingController priceBefore = TextEditingController();
  final TextEditingController components = TextEditingController();
  final TextEditingController description = TextEditingController();
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
    finalPrice.clear();
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
    description.text = product.description;
    productId = product.id;
    finalPrice.text = product.finalPrice;
    priceBefore.text = product.priceBefore;
    notifyListeners();
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  Future editProduct(BuildContext context) async {
    print(productId);
    print(sectionId);
    if (formKey.currentState!.validate()) {
      setLoading(true);
      formKey.currentState!.save();
      if(file != null){
        await Provider.of<GeneralViewModel>(context, listen: false)
            .uploadImage(context,file!)
            .then((photoResponse) async{
          print(photoResponse);
          if (photoResponse["status"] == "success") {
            await Provider.of<ApiServicesViewModel>(context, listen: false)
                .updateData(
              apiUrl: "$baseUrl/api/v1/product/$productId",
              headers: {
                'Authorization':
                Provider.of<UserViewModel>(context, listen: false).userToken
              },
              data: {
                "name": name.text.trim(),
                "component": components.text,
                "description":description.text,
                "priceBefore" : priceBefore.text.trim(),
                "finalPrice" : finalPrice.text.trim(),
                "photo" : photoResponse['data']['filePath']
              },)
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
          } else {
            setLoading(false);
            if (photoResponse["data"] is Map &&
                photoResponse["data"]["message"] != null) {
              showCustomToast(context, photoResponse["data"]["message"],
                  "assets/icons/alert-circle.webp", AppColors.c999);
            } else {
              print(photoResponse["data"]);
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
      } else {
        await Provider.of<ApiServicesViewModel>(context, listen: false)
            .updateData(
          apiUrl: "$baseUrl/api/v1/product/$productId",
          headers: {
            'Authorization':
            Provider.of<UserViewModel>(context, listen: false).userToken
          },
          data: {
            "name": name.text.trim(),
            "component": components.text,
            "description":description.text,
            "priceBefore" : priceBefore.text.trim(),
            "finalPrice" : finalPrice.text.trim(),
            "photo" : photoNetwork
          },)
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


}