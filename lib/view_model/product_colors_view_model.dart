import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:menu_dashboard/model/product_variant_model/product_variant_model.dart';
import 'package:provider/provider.dart';

import '../components/custom_toast.dart';
import '../model/product_size_model/product_size_model.dart';
import '../utilities/colors.dart';
import '../utilities/constants.dart';
import 'api_services_view_model.dart';
import 'product_view_model.dart';
import 'user_view_model.dart';

class ProductColorsViewModel with ChangeNotifier {
  List<ProductVariantModel> productColors = [];
  bool deleting = false;
  bool isColorsHomeLoading = true;
  bool isColorsLoading = true;

  String? colorId;

  updateSelectedItem({required String id}){
    colorId = id;
    notifyListeners();
  }

  void setColorsLoading(bool value) {
    isColorsLoading = value;
    notifyListeners();
  }

  void setColorsHomeLoading(bool value) {
    isColorsHomeLoading = value;
    notifyListeners();
  }

  void setDeleteItemLoading(bool value) {
    deleting = value;
    notifyListeners();
  }

  void clearItems() {
    productColors.clear();
    notifyListeners();
  }

  Future getProductColorsHome(
    BuildContext context,
    String productId,
  ) async {
    setColorsHomeLoading(true);
    clearItems();
    await Provider.of<ApiServicesViewModel>(context, listen: false).getData(
      apiUrl: "$baseUrl/api/v1/product/$productId/colors",
      headers: {
        'Authorization':
            Provider.of<UserViewModel>(context, listen: false).userToken
      },
    ).then((getItemsResponse) {
      if (getItemsResponse["status"] == "success") {
        clearItems();
        productColors = getItemsResponse["data"]["variants"]
            .map<ProductVariantModel>((e) => ProductVariantModel.fromJason(e))
            .toList();
        isColorsLoading = false;
        isColorsHomeLoading = false;
        notifyListeners();
      } else {
        setColorsLoading(false);
        setColorsHomeLoading(false);
        if (getItemsResponse["data"] is Map &&
            getItemsResponse["data"]["message"] != null) {
          showCustomToast(context, getItemsResponse["data"]["message"],
              "assets/icons/alert-circle.webp", AppColors.c999);
        } else {
          print(getItemsResponse["data"]);
          showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
              "assets/icons/alert-circle.webp", AppColors.c999);
        }
      }
    }).catchError((error) {
      if (error is DioException) {
        print('DioError in requestOrder: ${error.message}');
        setColorsLoading(false);
        setColorsHomeLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setColorsLoading(false);
        setColorsHomeLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      }
    });
  }

  Future getProductColors(BuildContext context, String productId) async {
    setColorsLoading(true);
    clearItems();
    await Provider.of<ApiServicesViewModel>(context, listen: false).getData(
      apiUrl: "$baseUrl/api/v1/product/$productId/colors",
      headers: {
        'Authorization':
            Provider.of<UserViewModel>(context, listen: false).userToken
      },
    ).then((getItemsResponse) {
      if (getItemsResponse["status"] == "success") {
        clearItems();
        productColors = getItemsResponse["data"]["variants"]
            .map<ProductVariantModel>((e) => ProductVariantModel.fromJason(e))
            .toList();
        isColorsLoading = false;
        notifyListeners();
      } else {
        setColorsLoading(false);
        if (getItemsResponse["data"] is Map &&
            getItemsResponse["data"]["message"] != null) {
          showCustomToast(context, getItemsResponse["data"]["message"],
              "assets/icons/alert-circle.webp", AppColors.c999);
        } else {
          print(getItemsResponse["data"]);
          showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
              "assets/icons/alert-circle.webp", AppColors.c999);
        }
      }
    }).catchError((error) {
      if (error is DioException) {
        print('DioError in requestOrder: ${error.message}');
        setColorsLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setColorsLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      }
    });
  }

  Future deleteColor(
      BuildContext context, String productId, String id) async {
    setDeleteItemLoading(true);
    await Provider.of<ApiServicesViewModel>(context, listen: false).deleteData(
        apiUrl: "$baseUrl/api/v1/product/$productId/colors",
        headers: {
          'Authorization':
              Provider.of<UserViewModel>(context, listen: false).userToken
        },
        data: {
          "id": id
        }).then((deleteItemResponse) {
      if (deleteItemResponse["status"] == "success") {
        setDeleteItemLoading(false);
        Navigator.pop(context);
        showCustomToast(context, "تم حذف اللون و السعر بنجاح",
            "assets/icons/check_c.webp", AppColors.c368);
        getProductColors(context, productId);
      } else {
        setDeleteItemLoading(false);
        if (deleteItemResponse["data"] is Map &&
            deleteItemResponse["data"]["message"] != null) {
          showCustomToast(context, deleteItemResponse["data"]["message"],
              "assets/icons/alert-circle.webp", AppColors.c999);
        } else {
          print(deleteItemResponse["data"]);
          showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
              "assets/icons/alert-circle.webp", AppColors.c999);
        }
      }
    }).catchError((error) {
      if (error is DioException) {
        print('DioError in requestOrder: ${error.message}');
        setDeleteItemLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setDeleteItemLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      }
    });
  }
}
