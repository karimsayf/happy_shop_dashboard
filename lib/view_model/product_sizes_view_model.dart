import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_toast.dart';
import '../model/product_size_model/product_size_model.dart';
import '../utilities/colors.dart';
import '../utilities/constants.dart';
import 'api_services_view_model.dart';
import 'product_view_model.dart';
import 'user_view_model.dart';

class ProductSizesViewModel with ChangeNotifier {
  List<ProductSizeModel> productSizes = [];
  bool deleting = false;
  bool isSizesHomeLoading = true;
  bool isSizesLoading = true;

  void setSizesLoading(bool value) {
    isSizesLoading = value;
    notifyListeners();
  }

  void setSizesHomeLoading(bool value) {
    isSizesHomeLoading = value;
    notifyListeners();
  }

  void setDeleteItemLoading(bool value) {
    deleting = value;
    notifyListeners();
  }

  void clearItems() {
    productSizes.clear();
    notifyListeners();
  }

  Future getProductSizesHome(
    BuildContext context,
    String productId,
  ) async {
    setSizesHomeLoading(true);
    clearItems();
    await Provider.of<ApiServicesViewModel>(context, listen: false).getData(
      apiUrl: "$baseUrl/api/v1/product/$productId/sizes",
      headers: {
        'Authorization':
            Provider.of<UserViewModel>(context, listen: false).userToken
      },
    ).then((getItemsResponse) {
      if (getItemsResponse["status"] == "success") {
        clearItems();
        productSizes = getItemsResponse["data"]["sizes"]
            .map<ProductSizeModel>((e) => ProductSizeModel.fromJason(e))
            .toList();
        isSizesLoading = false;
        isSizesHomeLoading = false;
        notifyListeners();
      } else {
        setSizesLoading(false);
        setSizesHomeLoading(false);
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
        setSizesLoading(false);
        setSizesHomeLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setSizesLoading(false);
        setSizesHomeLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      }
    });
  }

  Future getProductSizes(BuildContext context, String productId) async {
    setSizesLoading(true);
    clearItems();
    await Provider.of<ApiServicesViewModel>(context, listen: false).getData(
      apiUrl: "$baseUrl/api/v1/product/$productId/sizes",
      headers: {
        'Authorization':
            Provider.of<UserViewModel>(context, listen: false).userToken
      },
    ).then((getItemsResponse) {
      if (getItemsResponse["status"] == "success") {
        clearItems();
        productSizes = getItemsResponse["data"]["sizes"]
            .map<ProductSizeModel>((e) => ProductSizeModel.fromJason(e))
            .toList();
        isSizesLoading = false;
        notifyListeners();
      } else {
        setSizesLoading(false);
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
        setSizesLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setSizesLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      }
    });
  }

  Future deleteSize(
      BuildContext context, String productId, String sizeId) async {
    setDeleteItemLoading(true);
    await Provider.of<ApiServicesViewModel>(context, listen: false).deleteData(
        apiUrl: "$baseUrl/api/v1/product/$productId/sizes",
        headers: {
          'Authorization':
              Provider.of<UserViewModel>(context, listen: false).userToken
        },
        data: {
          "sizeId": sizeId
        }).then((deleteItemResponse) {
      if (deleteItemResponse["status"] == "success") {
        setDeleteItemLoading(false);
        Navigator.pop(context);
        showCustomToast(context, "تم حذف الحجم و السعر بنجاح",
            "assets/icons/check_c.webp", AppColors.c368);
        getProductSizes(context, productId);
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
