import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_toast.dart';
import '../model/product_model/product_model.dart';
import '../utilities/colors.dart';
import '../utilities/constants.dart';
import 'api_services_view_model.dart';
import 'user_view_model.dart';

class ProductViewModel with ChangeNotifier {
  List<ProductModel> products = [];
  int totalProducts = 0;
  bool isProductsHomeLoading = true;
  bool isProductsLoading = true;
  bool productsEmpty = false;
  TextEditingController searchController = TextEditingController();
  final int rowsPerPage = 10;
  int currentPage = 0;
  int firstNum = 1;
  int lastNum = 10;
  String searchQuery = "";
  bool deleting = false;
  String selectedProductId = "";
  String selectedProductName = "";
  List<dynamic> productSizes = [];


  void setPage(int page) {
    currentPage = page;
    notifyListeners();
  }

  void setProductsLoading(bool value) {
    isProductsLoading = value;
    notifyListeners();
  }

  void setProductsHomeLoading(bool value) {
    isProductsHomeLoading = value;
    notifyListeners();
  }

  void setDeleteSubSectionsLoading(bool value) {
    deleting = value;
    notifyListeners();
  }

  void clearSubSections() {
    products.clear();
    notifyListeners();
  }

  void clearData() {
    currentPage = 0;
    firstNum = 1;
    lastNum = 10;
    searchQuery = "";
    searchController.clear();
    selectedProductId = "";
    selectedProductName = "";
    notifyListeners();
  }

  void updateSelectedItemId(String id, String name, List<dynamic> sizes) {
    selectedProductId = id;
    selectedProductName = name;
    productSizes = sizes;
    notifyListeners();
  }

  Future getProductsHome(BuildContext context, String page) async {
    setProductsHomeLoading(true);
    clearSubSections();
    clearData();
    await Provider.of<ApiServicesViewModel>(context, listen: false).getData(
      apiUrl: "$baseUrl/api/v1/allProducts?page=$page&size=10",
      headers: {
        'Authorization':
            Provider.of<UserViewModel>(context, listen: false).userToken
      },
    ).then((getSubsectionsResponse) {
      if (getSubsectionsResponse["status"] == "success") {
        for (int i = 0;
            i < getSubsectionsResponse["data"]["product"].length;
            i++) {
          products.add(ProductModel.fromJason(
              getSubsectionsResponse["data"]["product"][i]));
        }
        if (products.isEmpty) {
          productsEmpty = true;
        } else {
          productsEmpty = false;
        }
        totalProducts = getSubsectionsResponse["data"]["totalProduct"];
        isProductsLoading = false;
        isProductsHomeLoading = false;
        notifyListeners();
      } else {
        setProductsLoading(false);
        setProductsHomeLoading(false);
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
        print('DioError in requestOrder: ${error.message}');
        setProductsLoading(false);
        setProductsHomeLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setProductsLoading(false);
        setProductsHomeLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      }
    });
  }

  Future getProducts(BuildContext context, String page, bool clear) async {
    setProductsLoading(true);
    clearSubSections();
    if (clear) {
      clearData();
    }
    await Provider.of<ApiServicesViewModel>(context, listen: false).getData(
      apiUrl: "$baseUrl/api/v1/allProducts?page=$page&size=10",
      headers: {
        'Authorization':
            Provider.of<UserViewModel>(context, listen: false).userToken
      },
    ).then((getSubsectionsResponse) {
      print(getSubsectionsResponse);
      if (getSubsectionsResponse["status"] == "success") {
        for (int i = 0;
            i < getSubsectionsResponse["data"]["product"].length;
            i++) {
          products = getSubsectionsResponse["data"]["product"]
              .map<ProductModel>((e) => ProductModel.fromJason(e))
              .toList();
        }
        if (products.isEmpty) {
          productsEmpty = true;
        } else {
          productsEmpty = false;
        }
        totalProducts = getSubsectionsResponse["data"]["totalProduct"];
        isProductsLoading = false;
        notifyListeners();
      } else {
        setProductsLoading(false);
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
        print('DioError in requestOrder: ${error.message}');
        setProductsLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setProductsLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      }
    });
  }

  Future searchProducts(
      BuildContext context, String query, String page, bool clear) async {
    setProductsLoading(true);
    clearSubSections();
    if (clear) {
      clearData();
    }
    await Provider.of<ApiServicesViewModel>(context, listen: false)
        .getData(
            apiUrl: "$baseUrl/api/v1/product?name=$query&page=$page&size=10",
      headers: {
        'Authorization':
        Provider.of<UserViewModel>(context, listen: false).userToken
      },)
        .then((searchSubsectionsResponse) {
      {
        if (searchSubsectionsResponse["status"] == "success") {
          products = searchSubsectionsResponse["data"]["product"]
              .map<ProductModel>((e) => ProductModel.fromJason(e))
              .toList();
          if (products.isEmpty) {
            productsEmpty = true;
          } else {
            productsEmpty = false;
          }
          totalProducts = searchSubsectionsResponse["data"]["totalProduct"];
          isProductsLoading = false;
          notifyListeners();
        } else {
          setProductsLoading(false);
          if (searchSubsectionsResponse["data"] is Map &&
              searchSubsectionsResponse["data"]["message"] != null) {
            showCustomToast(
                context,
                searchSubsectionsResponse["data"]["message"],
                "assets/icons/alert-circle.webp",
                AppColors.c999);
          } else {
            print(searchSubsectionsResponse["data"]);
            showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
                "assets/icons/alert-circle.webp", AppColors.c999);
          }
        }
      }
    }).catchError((error) {
      if (error is DioException) {
        print('DioError in requestOrder: ${error.message}');
        setProductsLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setProductsLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      }
    });
  }

  Future deleteProduct(BuildContext context, String productId) async {
    setDeleteSubSectionsLoading(true);
    await Provider.of<ApiServicesViewModel>(context, listen: false).deleteData(
      apiUrl: "$baseUrl/api/v1/product/$productId",
      headers: {
        'Authorization':
            Provider.of<UserViewModel>(context, listen: false).userToken
      },
    ).then((deleteSubsectionResponse) {
      if (deleteSubsectionResponse["status"] == "success") {
        setDeleteSubSectionsLoading(false);
        Navigator.pop(context);
        showCustomToast(context, "تم حذف المنتج بنجاح",
            "assets/icons/check_c.webp", AppColors.c368);
        getProducts(context, "0", true);
      } else {
        setDeleteSubSectionsLoading(false);
        if (deleteSubsectionResponse["data"] is Map &&
            deleteSubsectionResponse["data"]["message"] != null) {
          showCustomToast(context, deleteSubsectionResponse["data"]["message"],
              "assets/icons/alert-circle.webp", AppColors.c999);
        } else {
          print(deleteSubsectionResponse["data"]);
          showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
              "assets/icons/alert-circle.webp", AppColors.c999);
        }
      }
    }).catchError((error) {
      if (error is DioException) {
        print('DioError in requestOrder: ${error.message}');
        setDeleteSubSectionsLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setDeleteSubSectionsLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      }
    });
  }
}
