import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_toast.dart';
import '../model/section_model/section_model.dart';
import '../utilities/colors.dart';
import '../utilities/constants.dart';
import 'api_services_view_model.dart';
import 'user_view_model.dart';

class BannersViewModel with ChangeNotifier {
  List banners = [];
  int totalSections = 0;
  bool isBannersHomeLoading = true;
  bool isBannersLoading = true;
  bool bannersEmpty = false;
  TextEditingController searchController = TextEditingController();
  final int rowsPerPage = 10;
  int currentPage = 0;
  int firstNum = 1;
  int lastNum = 10;
  bool deleting = false;

  void setPage(int page) {
    currentPage = page;
    notifyListeners();
  }

  void setBannersLoading(bool value) {
    isBannersLoading = value;
    notifyListeners();
  }

  void setBannersHomeLoading(bool value) {
    isBannersHomeLoading = value;
    notifyListeners();
  }

  void setDeleteBannerLoading(bool value) {
    deleting = value;
    notifyListeners();
  }

  void clearBanners() {
    banners.clear();
    notifyListeners();
  }

  void clearData() {
    currentPage = 0;
    firstNum = 1;
    lastNum = 10;
    searchController.clear();
    notifyListeners();
  }

  Future getBannersHome(BuildContext context, String page) async {
    setBannersHomeLoading(true);
    clearBanners();
    clearData();
    await Provider.of<ApiServicesViewModel>(context, listen: false)
        .getData(

        apiUrl: "$baseUrl/api/v1/getAllBanners?page=$page&size=10",
      headers: {
        'Authorization':
        Provider.of<UserViewModel>(context, listen: false).userToken
      },)
        .then((getBannersResponse) {
      if (getBannersResponse["status"] == "success") {
        clearBanners();
        clearData();
        banners = getBannersResponse["data"]["banner"]
            .toList();
        if (banners.isEmpty) {
          bannersEmpty = true;
        } else {
          bannersEmpty = false;
        }
        totalSections = getBannersResponse["data"]["totalBanner"];
        isBannersLoading = false;
        isBannersHomeLoading = false;
        notifyListeners();
      } else {
        setBannersHomeLoading(false);
        setBannersLoading(false);
        if (getBannersResponse["data"] is Map &&
            getBannersResponse["data"]["message"] != null) {
          showCustomToast(context, getBannersResponse["data"]["message"],
              "assets/icons/alert-circle.webp", AppColors.c999);
        } else {
          print(getBannersResponse["data"]);
          showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
              "assets/icons/alert-circle.webp", AppColors.c999);
        }
      }
    });
  }

  Future getBanners(BuildContext context, String page, bool clear) async {
    setBannersLoading(true);
    clearBanners();
    if (clear) {
      clearData();
    }
    await Provider.of<ApiServicesViewModel>(context, listen: false)
        .getData(
        apiUrl: "$baseUrl/api/v1/getAllBanners?page=$page&size=10",
      headers: {
        'Authorization':
        Provider.of<UserViewModel>(context, listen: false).userToken
      },)
        .then((getBannersResponse) {
      print(getBannersResponse);
      if (getBannersResponse["status"] == "success") {
        clearBanners();
          banners = getBannersResponse["data"]["banner"]
              .toList();
        if (banners.isEmpty) {
          bannersEmpty = true;
        } else {
          bannersEmpty = false;
        }
        totalSections = getBannersResponse["data"]["totalBanner"];
        isBannersLoading = false;
        notifyListeners();
      } else {
        setBannersLoading(false);
        if (getBannersResponse["data"] is Map &&
            getBannersResponse["data"]["message"] != null) {
          showCustomToast(context, getBannersResponse["data"]["message"],
              "assets/icons/alert-circle.webp", AppColors.c999);
        } else {
          print(getBannersResponse["data"]);
          showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
              "assets/icons/alert-circle.webp", AppColors.c999);
        }
      }
    }).catchError((error) {
      if (error is DioException) {
        print('DioError in requestOrder: ${error.message}');
        setBannersLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setBannersLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      }
    });
  }

  Future deleteBanner(BuildContext context, String bannerId) async {
    setDeleteBannerLoading(true);
    await Provider.of<ApiServicesViewModel>(context, listen: false).deleteData(
      apiUrl: "$baseUrl/api/v1/banner/$bannerId",
      headers: {
        'Authorization':
        Provider.of<UserViewModel>(context, listen: false).userToken
      },
    ).then((deleteBannerResponse) {
      if (deleteBannerResponse["status"] == "success") {
        setDeleteBannerLoading(false);
        Navigator.pop(context);
        showCustomToast(context, "تم حذف القسم بنجاح",
            "assets/icons/check_c.webp", AppColors.c368);
        getBanners(context, "0", true);
      } else {
        setDeleteBannerLoading(false);
        if (deleteBannerResponse["data"] is Map &&
            deleteBannerResponse["data"]["message"] != null) {
          print(deleteBannerResponse["data"]);
          showCustomToast(context, deleteBannerResponse["data"]["message"],
              "assets/icons/alert-circle.webp", AppColors.c999);
        } else {
          print(deleteBannerResponse["data"]);
          showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
              "assets/icons/alert-circle.webp", AppColors.c999);
        }
      }
    }).catchError((error) {
      if (error is DioException) {
        print('DioError in requestOrder: ${error.message}');
        setDeleteBannerLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setDeleteBannerLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      }
    });
  }

}