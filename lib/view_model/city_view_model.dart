import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:menu_dashboard/model/city_model/city_model.dart';
import 'package:provider/provider.dart';

import '../components/custom_toast.dart';
import '../model/employee_model/employee_model.dart';
import '../utilities/colors.dart';
import '../utilities/constants.dart';
import 'api_services_view_model.dart';
import 'user_view_model.dart';

class CityViewModel with ChangeNotifier {
  List<CityModel> cities = [];
  bool isCityHomeLoading = true;
  bool isCityLoading = true;
  bool cityEmpty = false;
  bool deleting = false;
  bool updatingStatus = false;
  String searchQuery = "";

  void setCityLoading(bool value) {
    isCityLoading = value;
    notifyListeners();
  }

  void setCityHomeLoading(bool value) {
    isCityHomeLoading = value;
    notifyListeners();
  }

  void setDeleteLoading(bool value) {
    deleting = value;
    notifyListeners();
  }

  void setUpdateStatusLoading(bool value) {
    updatingStatus = value;
    notifyListeners();
  }

  void clearCity() {
    cities.clear();
    notifyListeners();
  }


  void clearData() {
    searchQuery = "";
    notifyListeners();
  }

  Future getCityHome(BuildContext context,) async {
    setCityHomeLoading(true);
    clearCity();
    clearData();
    await Provider.of<ApiServicesViewModel>(context, listen: false).getData(
        apiUrl: "$baseUrl/api/v1/city",
        headers: {
          'Authorization':
              Provider.of<UserViewModel>(context, listen: false).userToken
        }).then((getCustomersResponse) {
      if (getCustomersResponse["status"] == "success") {
        clearCity();
        clearData();
        cities = getCustomersResponse["data"]["city"]
            .map<CityModel>((e) => CityModel.fromJason(e))
            .toList();
        if (cities.isEmpty) {
          cityEmpty = true;
        } else {
          cityEmpty = false;
        }
        isCityLoading = false;
        isCityHomeLoading = false;
        notifyListeners();
      } else {
        setCityHomeLoading(false);
        setCityLoading(false);
        if (getCustomersResponse["data"] is Map &&
            getCustomersResponse["data"]["message"] != null) {
          showCustomToast(context, getCustomersResponse["data"]["message"],
              "assets/icons/alert-circle.webp", AppColors.c999);
        } else {
          print(getCustomersResponse["data"]);
          showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
              "assets/icons/alert-circle.webp", AppColors.c999);
        }
      }
    }).catchError((error) {
      if (error is DioException) {
        print('DioError in requestOrder: ${error.message}');
        setCityHomeLoading(false);
        setCityLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setCityHomeLoading(false);
        setCityLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      }
    });
  }

  Future getCities(BuildContext context,bool clear) async {
    setCityLoading(true);
    clearCity();
    if (clear) {
      clearData();
    }
    await Provider.of<ApiServicesViewModel>(context, listen: false).getData(
        apiUrl: "$baseUrl/api/v1/city",
        headers: {
          'Authorization':
              Provider.of<UserViewModel>(context, listen: false).userToken
        }).then((getCustomersResponse) {
      if (getCustomersResponse["status"] == "success") {
        clearCity();
        cities = getCustomersResponse["data"]["city"]
            .map<CityModel>((e) => CityModel.fromJason(e))
            .toList();
        if (cities.isEmpty) {
          cityEmpty = true;
        } else {
          cityEmpty = false;
        }
        isCityLoading = false;
        notifyListeners();
      } else {
        setCityLoading(false);
        if (getCustomersResponse["data"] is Map &&
            getCustomersResponse["data"]["message"] != null) {
          showCustomToast(context, getCustomersResponse["data"]["message"],
              "assets/icons/alert-circle.webp", AppColors.c999);
        } else {
          print(getCustomersResponse["data"]);
          showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
              "assets/icons/alert-circle.webp", AppColors.c999);
        }
      }
    }).catchError((error) {
      if (error is DioException) {
        print('DioError in requestOrder: ${error.message}');
        setCityLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setCityLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      }
    });
  }

  Future deleteCity(BuildContext context, String cityId) async {
    setDeleteLoading(true);
    await Provider.of<ApiServicesViewModel>(context, listen: false).deleteData(
        apiUrl: "$baseUrl/api/v1/city/$cityId",
        headers: {
          'Authorization':
              Provider.of<UserViewModel>(context, listen: false).userToken
        }).then((deleteSubsectionsResponse) {
      if (deleteSubsectionsResponse["status"] == "success") {
        setDeleteLoading(false);
        Navigator.pop(context);
        showCustomToast(context, "تم حذف المدينة بنجاح",
            "assets/icons/check_c.webp", AppColors.c368);
        getCities(context,  true);
      } else {
        setDeleteLoading(false);
        if (deleteSubsectionsResponse["data"] is Map &&
            deleteSubsectionsResponse["data"]["message"] != null) {
          showCustomToast(context, deleteSubsectionsResponse["data"]["message"],
              "assets/icons/alert-circle.webp", AppColors.c999);
        } else {
          print(deleteSubsectionsResponse["data"]);
          showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
              "assets/icons/alert-circle.webp", AppColors.c999);
        }
      }
    }).catchError((error) {
      if (error is DioException) {
        print('DioError in requestOrder: ${error.message}');
        setDeleteLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setDeleteLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      }
    });
  }


}
