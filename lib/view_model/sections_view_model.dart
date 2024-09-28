import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_toast.dart';
import '../model/section_model/section_model.dart';
import '../utilities/colors.dart';
import '../utilities/constants.dart';
import 'api_services_view_model.dart';
import 'user_view_model.dart';

class SectionsViewModel with ChangeNotifier {
  List<SectionModel> sections = [];
  int totalSections = 0;
  bool isSectionsHomeLoading = true;
  bool isSectionsLoading = true;
  bool sectionsEmpty = false;
  TextEditingController searchController = TextEditingController();
  final int rowsPerPage = 10;
  int currentPage = 0;
  int firstNum = 1;
  int lastNum = 10;
  String searchQuery = "";
  bool deleting = false;

  void setPage(int page) {
    currentPage = page;
    notifyListeners();
  }

  void setSectionsLoading(bool value) {
    isSectionsLoading = value;
    notifyListeners();
  }

  void setSectionsHomeLoading(bool value) {
    isSectionsHomeLoading = value;
    notifyListeners();
  }

  void setDeleteSubSectionsLoading(bool value) {
    deleting = value;
    notifyListeners();
  }

  void clearSubSections() {
    sections.clear();
    notifyListeners();
  }

  void clearData() {
    currentPage = 0;
    firstNum = 1;
    lastNum = 10;
    searchQuery = "";
    searchController.clear();
    notifyListeners();
  }

  Future getSectionsHome(BuildContext context, String page) async {
    setSectionsHomeLoading(true);
    clearSubSections();
    clearData();
    await Provider.of<ApiServicesViewModel>(context, listen: false)
        .getData(

        apiUrl: "$baseUrl/api/v1/category?page=$page&size=10",
      headers: {
        'Authorization':
        Provider.of<UserViewModel>(context, listen: false).userToken
      },)
        .then((getSubsectionsResponse) {
      if (getSubsectionsResponse["status"] == "success") {
        clearSubSections();
        clearData();
        sections = getSubsectionsResponse["data"]["category"]
            .map<SectionModel>((e) => SectionModel.fromJason(e))
            .toList();
        if (sections.isEmpty) {
          sectionsEmpty = true;
        } else {
          sectionsEmpty = false;
        }
        totalSections = getSubsectionsResponse["data"]["totalCategory"];
        isSectionsLoading = false;
        isSectionsHomeLoading = false;
        notifyListeners();
      } else {
        setSectionsHomeLoading(false);
        setSectionsLoading(false);
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
    });
  }

  Future getSections(BuildContext context, String page, bool clear) async {
    setSectionsLoading(true);
    clearSubSections();
    if (clear) {
      clearData();
    }
    await Provider.of<ApiServicesViewModel>(context, listen: false)
        .getData(
        apiUrl: "$baseUrl/api/v1/category?page=$page&size=10",
      headers: {
        'Authorization':
        Provider.of<UserViewModel>(context, listen: false).userToken
      },)
        .then((getSubsectionsResponse) {
      print(getSubsectionsResponse);
      if (getSubsectionsResponse["status"] == "success") {
        clearSubSections();
          sections = getSubsectionsResponse["data"]["category"]
              .map<SectionModel>((e) => SectionModel.fromJason(e))
              .toList();
        if (sections.isEmpty) {
          sectionsEmpty = true;
        } else {
          sectionsEmpty = false;
        }
        totalSections = getSubsectionsResponse["data"]["totalCategory"];
        isSectionsLoading = false;
        notifyListeners();
      } else {
        setSectionsLoading(false);
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
        setSectionsLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setSectionsLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      }
    });
  }

  Future searchSections(
      BuildContext context, String query, String page, bool clear) async {
    setSectionsLoading(true);
    clearSubSections();
    if (clear) {
      clearData();
    }
    await Provider.of<ApiServicesViewModel>(context, listen: false)
        .getData(
        apiUrl:
        "$baseUrl/api/v1/category/search?name=$query&page=$page&size=10",
      headers: {
        'Authorization':
        Provider.of<UserViewModel>(context, listen: false).userToken
      },)
        .then((searchSubsectionsResponse) {
      {
        if (searchSubsectionsResponse["status"] == "success") {
          sections = searchSubsectionsResponse["data"]["category"]
              .map<SectionModel>((e) => SectionModel.fromJason(e))
              .toList();
          if (sections.isEmpty) {
            sectionsEmpty = true;
          } else {
            sectionsEmpty = false;
          }
          totalSections = searchSubsectionsResponse["data"]["totalCategory"];
          isSectionsLoading = false;
          notifyListeners();
        } else {
          setSectionsLoading(false);
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
        setSectionsLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setSectionsLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      }
    });
  }

  Future deleteSection(BuildContext context, String sectionId) async {
    setDeleteSubSectionsLoading(true);
    await Provider.of<ApiServicesViewModel>(context, listen: false).deleteData(
      apiUrl: "$baseUrl/api/v1/category/$sectionId",
      headers: {
        'Authorization':
        Provider.of<UserViewModel>(context, listen: false).userToken
      },
    ).then((deleteSubsectionResponse) {
      if (deleteSubsectionResponse["status"] == "success") {
        setDeleteSubSectionsLoading(false);
        Navigator.pop(context);
        showCustomToast(context, "تم حذف القسم بنجاح",
            "assets/icons/check_c.webp", AppColors.c368);
        getSections(context, "0", true);
      } else {
        setDeleteSubSectionsLoading(false);
        if (deleteSubsectionResponse["data"] is Map &&
            deleteSubsectionResponse["data"]["message"] != null) {
          print(deleteSubsectionResponse["data"]);
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