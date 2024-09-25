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

  void setDeleteItemLoading(bool value) {
    deleting = value;
    notifyListeners();
  }

  void clearItems() {
    productSizes.clear();
    notifyListeners();
  }

  getSizes(BuildContext context, List<dynamic> sizes) {
    clearItems();
    productSizes =
        sizes.map<ProductSizeModel>((e) => ProductSizeModel.fromJason(e)).toList();
    notifyListeners();
  }

  Future deleteSize(BuildContext context, String productId ,String productSizeId) async {
    setDeleteItemLoading(true);
    List data = Provider.of<ProductViewModel>(context,listen: false).productSizes;
    data.removeWhere((element) => element['_id'] == productSizeId,);
    await Provider.of<ApiServicesViewModel>(context, listen: false).updateData(
      apiUrl: "$baseUrl/api/v1/product/$productId",
      headers: {
        'Authorization':
            Provider.of<UserViewModel>(context, listen: false).userToken
      },
        data: {
          "sizes":[
            ...data.map((size)=>
            {
              "sizeId": size['sizeId'],
              "name": size['name'],
              "price": size['price'],
            }),
          ]
        }
    ).then((deleteItemResponse) {
      if (deleteItemResponse["status"] == "success") {
        productSizes.removeWhere((size) => size.id == productSizeId);
        setDeleteItemLoading(false);
        Navigator.pop(context);
        showCustomToast(context, "تم حذف الحجم و السعر بنجاح",
            "assets/icons/check_c.webp", AppColors.c368);
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
