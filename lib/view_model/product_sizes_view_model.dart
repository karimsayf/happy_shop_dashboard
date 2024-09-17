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
  int totalSizes = 0;
  bool isSizesHomeLoading = true;
  bool isSizesLoading = true;
  bool sizesEmpty = false;
  final int rowsPerPage = 10;
  int currentPage = 0;
  int firstNum = 1;
  int lastNum = 10;
  bool deleting = false;


  void setPage(int page) {
    currentPage = page;
    notifyListeners();
  }

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

  void clearData() {
    currentPage = 0;
    firstNum = 1;
    lastNum = 10;
    notifyListeners();
  }

  Future getSizesHome(BuildContext context, String productId,String page) async {
    setSizesHomeLoading(true);
    clearItems();
    clearData();
    await Provider.of<ApiServicesViewModel>(context, listen: false)
        .getData(
        apiUrl: "$baseUrl/api/product/$productId/sizes?page=$page&size=10")
        .then((getItemsResponse) {
      if (getItemsResponse["status"] == "success") {
        for (int i = 0;
        i <
            getItemsResponse["data"]["content"]
                .length;
        i++) {
          productSizes.add(ProductSizeModel.fromJason(
              getItemsResponse["data"]["content"][i]));
        }
        if (productSizes.isEmpty) {
          sizesEmpty = true;
        } else {
          sizesEmpty = false;
        }
        totalSizes = getItemsResponse["data"]["totalElements"];
        isSizesLoading = false;
        isSizesHomeLoading = false;
        notifyListeners();
      } else {
        setSizesLoading(false);
        setSizesHomeLoading(false);
        if (getItemsResponse["data"] is Map &&
            getItemsResponse["data"]["message"] != null) {
          showCustomToast(context,getItemsResponse["data"]["message"],"assets/icons/alert-circle.webp",AppColors.c999);
        } else {
          print(getItemsResponse["data"]);
          showCustomToast(context,"حدثت مشكله ما حاول مره اخري","assets/icons/alert-circle.webp",AppColors.c999);
        }
      }
    }).catchError((error) {
      if (error is DioException) {
        print('DioError in requestOrder: ${error.message}');
        setSizesLoading(false);
        setSizesHomeLoading(false);
        showCustomToast(context,"حدثت مشكله ما حاول مره اخري","assets/icons/alert-circle.webp",AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setSizesLoading(false);
        setSizesHomeLoading(false);
        showCustomToast(context,"حدثت مشكله ما حاول مره اخري","assets/icons/alert-circle.webp",AppColors.c999);
      }
    });
  }

  Future getSizes(BuildContext context, String productId, String page,bool clear) async {
    setSizesLoading(true);
    clearItems();
    if(clear)
    {
      clearData();
    }
    await Provider.of<ApiServicesViewModel>(context, listen: false)
        .getData(
        apiUrl: "$baseUrl/api/product/$productId/sizes?page=$page&size=10")
        .then((getItemsResponse) {
      if (getItemsResponse["status"] == "success") {
        for (int i = 0;
        i <
            getItemsResponse["data"]["content"]
                .length;
        i++) {
          productSizes.add(ProductSizeModel.fromJason(
              getItemsResponse["data"]["content"][i]));
        }
        if (productSizes.isEmpty) {
          sizesEmpty = true;
        } else {
          sizesEmpty = false;
        }
        totalSizes = getItemsResponse["data"]["totalElements"];
        isSizesLoading = false;
        notifyListeners();
      } else {
        setSizesLoading(false);
        if (getItemsResponse["data"] is Map &&
            getItemsResponse["data"]["message"] != null) {
          showCustomToast(context,getItemsResponse["data"]["message"],"assets/icons/alert-circle.webp",AppColors.c999);
        } else {
          print(getItemsResponse["data"]);
          showCustomToast(context,"حدثت مشكله ما حاول مره اخري","assets/icons/alert-circle.webp",AppColors.c999);
        }
      }
    }).catchError((error) {
      if (error is DioException) {
        print('DioError in requestOrder: ${error.message}');
        setSizesLoading(false);
        showCustomToast(context,"حدثت مشكله ما حاول مره اخري","assets/icons/alert-circle.webp",AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setSizesLoading(false);
        showCustomToast(context,"حدثت مشكله ما حاول مره اخري","assets/icons/alert-circle.webp",AppColors.c999);
      }
    });
  }

  Future deleteSize(BuildContext context, String sizeId) async {
    setDeleteItemLoading(true);
    await Provider.of<ApiServicesViewModel>(context, listen: false)
        .deleteData(apiUrl: "$baseUrl/api/product/size/$sizeId",
      headers: {
        'Authorization':
        'Bearer ${Provider.of<UserViewModel>(context, listen: false).userToken}'
      },
    )
        .then((deleteItemResponse) {
      if (deleteItemResponse["status"] == "success") {
        setDeleteItemLoading(false);
        Navigator.pop(context);
        showCustomToast(context,"تم حذف الحجم و السعر بنجاح","assets/icons/check_c.webp",AppColors.c368);
        getSizes(context, Provider.of<ProductViewModel>(context, listen: false).selectedProductId, "0",true);
      } else {
        setDeleteItemLoading(false);
        if (deleteItemResponse["data"] is Map &&
            deleteItemResponse["data"]["message"] != null) {
          showCustomToast(context,deleteItemResponse["data"]["message"],"assets/icons/alert-circle.webp",AppColors.c999);
        } else {
          print(deleteItemResponse["data"]);
          showCustomToast(context,"حدثت مشكله ما حاول مره اخري","assets/icons/alert-circle.webp",AppColors.c999);
        }
      }
    }).catchError((error) {
      if (error is DioException) {
        print('DioError in requestOrder: ${error.message}');
        setDeleteItemLoading(false);
        showCustomToast(context,"حدثت مشكله ما حاول مره اخري","assets/icons/alert-circle.webp",AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setDeleteItemLoading(false);
        showCustomToast(context,"حدثت مشكله ما حاول مره اخري","assets/icons/alert-circle.webp",AppColors.c999);
      }
    });
  }

}