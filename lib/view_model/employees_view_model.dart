import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_toast.dart';
import '../model/employee_model/employee_model.dart';
import '../utilities/colors.dart';
import '../utilities/constants.dart';
import 'api_services_view_model.dart';
import 'user_view_model.dart';

class EmployeesViewModel with ChangeNotifier {
  List<EmployeeModel> employees = [];
  int totalEmployees = 0;
  bool isEmployeesHomeLoading = true;
  bool isEmployeesLoading = true;
  bool employeesEmpty = false;
  TextEditingController searchController = TextEditingController();
  final int rowsPerPage = 10;
  int currentPage = 0;
  int firstNum = 1;
  int lastNum = 10;
  bool deleting = false;
  bool updatingStatus = false;
  String searchQuery = "";

  void setEmployeesLoading(bool value) {
    isEmployeesLoading = value;
    notifyListeners();
  }

  void setEmployeesHomeLoading(bool value) {
    isEmployeesHomeLoading = value;
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

  void clearEmployees() {
    employees.clear();
    notifyListeners();
  }

  void setPage(int page) {
    currentPage = page;
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

  Future getEmployeesHome(BuildContext context, String page) async {
    setEmployeesHomeLoading(true);
    clearEmployees();
    clearData();
    await Provider.of<ApiServicesViewModel>(context, listen: false)
        .getData(
        apiUrl:
        "$baseUrl/api/v1/employees?page=$page&size=10",
        headers: {
          'Authorization':
          Provider.of<UserViewModel>(context, listen: false).userToken
        })
        .then((getCustomersResponse) {
      if (getCustomersResponse["status"] == "success") {
        for (int i = 0;
        i <
            getCustomersResponse["data"]["employees"]
                .length;
        i++) {
          employees.add(EmployeeModel.fromJason(
              getCustomersResponse["data"]["employees"][i]));
        }
        if (employees.isEmpty) {
          employeesEmpty = true;
        } else {
          employeesEmpty = false;
        }
        totalEmployees = getCustomersResponse["data"]["totalEmployees"];
        isEmployeesLoading = false;
        isEmployeesHomeLoading = false;
        notifyListeners();
      } else {
        setEmployeesHomeLoading(false);
        setEmployeesLoading(false);
        if (getCustomersResponse["data"] is Map &&
            getCustomersResponse["data"]["message"] != null) {
          showCustomToast(context,getCustomersResponse["data"]["message"],"assets/icons/alert-circle.webp",AppColors.c999);
        } else {
          print(getCustomersResponse["data"]);
          showCustomToast(context,"حدثت مشكله ما حاول مره اخري","assets/icons/alert-circle.webp",AppColors.c999);
        }
      }
    }).catchError((error) {
      if (error is DioException) {
        print('DioError in requestOrder: ${error.message}');
        setEmployeesHomeLoading(false);
        setEmployeesLoading(false);
        showCustomToast(context,"حدثت مشكله ما حاول مره اخري","assets/icons/alert-circle.webp",AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setEmployeesHomeLoading(false);
        setEmployeesLoading(false);
        showCustomToast(context,"حدثت مشكله ما حاول مره اخري","assets/icons/alert-circle.webp",AppColors.c999);
      }
    });
  }

  Future getEmployees(BuildContext context, String page, bool clear) async {
    setEmployeesLoading(true);
    clearEmployees();
    if(clear)
    {
      clearData();
    }
    await Provider.of<ApiServicesViewModel>(context, listen: false)
        .getData(
        apiUrl:
        "$baseUrl/api/v1/employees?page=$page&size=10",
        headers: {
          'Authorization':
          Provider.of<UserViewModel>(context, listen: false).userToken
        })
        .then((getCustomersResponse) {
      if (getCustomersResponse["status"] == "success") {
        for (int i = 0;
        i <
            getCustomersResponse["data"]["employees"]
                .length;
        i++) {
          employees= getCustomersResponse["data"]["employees"].map<EmployeeModel>((e)=>EmployeeModel.fromJason(
              e)).toList();
        }
        if (employees.isEmpty) {
          employeesEmpty = true;
        } else {
          employeesEmpty = false;
        }
        totalEmployees = getCustomersResponse["data"]["totalEmployees"];
        isEmployeesLoading = false;
        notifyListeners();
      } else {
        setEmployeesLoading(false);
        if (getCustomersResponse["data"] is Map &&
            getCustomersResponse["data"]["message"] != null) {
          showCustomToast(context,getCustomersResponse["data"]["message"],"assets/icons/alert-circle.webp",AppColors.c999);
        } else {
          print(getCustomersResponse["data"]);
          showCustomToast(context,"حدثت مشكله ما حاول مره اخري","assets/icons/alert-circle.webp",AppColors.c999);
        }
      }
    }).catchError((error) {
      if (error is DioException) {
        print('DioError in requestOrder: ${error.message}');
        setEmployeesLoading(false);
        showCustomToast(context,"حدثت مشكله ما حاول مره اخري","assets/icons/alert-circle.webp",AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setEmployeesLoading(false);
        showCustomToast(context,"حدثت مشكله ما حاول مره اخري","assets/icons/alert-circle.webp",AppColors.c999);
      }
    });
  }

  Future searchEmployees(BuildContext context, String query , String page, bool clear) async {
    setEmployeesLoading(true);
    clearEmployees();
    if(clear)
    {
      clearData();
    }
    await Provider.of<ApiServicesViewModel>(context, listen: false)
        .getData(
        apiUrl:
        "$baseUrl/api/v1/employees/search?name=$query&page=$page&size=10",
        headers: {
          'Authorization':
          Provider.of<UserViewModel>(context, listen: false).userToken
        })
        .then((searchCustomersResponse) {
      if (searchCustomersResponse["status"] == "success") {
          employees= searchCustomersResponse["data"]["employees"].map<EmployeeModel>((e)=>EmployeeModel.fromJason(
              e)).toList();
        if (employees.isEmpty) {
          employeesEmpty = true;
        } else {
          employeesEmpty = false;
        }
        totalEmployees = searchCustomersResponse["data"]["totalEmployees"];
        isEmployeesLoading = false;
        notifyListeners();
      } else {
        setEmployeesLoading(false);
        if (searchCustomersResponse["data"] is Map &&
            searchCustomersResponse["data"]["message"] != null) {
          showCustomToast(context,searchCustomersResponse["data"]["message"],"assets/icons/alert-circle.webp",AppColors.c999);
        } else {
          print(searchCustomersResponse["data"]);
          showCustomToast(context,"حدثت مشكله ما حاول مره اخري","assets/icons/alert-circle.webp",AppColors.c999);
        }
      }
    }).catchError((error) {
      if (error is DioException) {
        print('DioError in requestOrder: ${error.message}');
        setEmployeesLoading(false);
        showCustomToast(context,"حدثت مشكله ما حاول مره اخري","assets/icons/alert-circle.webp",AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setEmployeesLoading(false);
        showCustomToast(context,"حدثت مشكله ما حاول مره اخري","assets/icons/alert-circle.webp",AppColors.c999);
      }
    });
  }

  Future deleteEmployee(BuildContext context, String employeeId) async {
    setDeleteLoading(true);
    await Provider.of<ApiServicesViewModel>(context, listen: false)
        .deleteData(apiUrl: "$baseUrl/api/v1/employees/$employeeId",
        headers: {
          'Authorization':
          Provider.of<UserViewModel>(context, listen: false).userToken
        })
        .then((deleteSubsectionsResponse) {
      if (deleteSubsectionsResponse["status"] == "success") {
        setDeleteLoading(false);
        Navigator.pop(context);
        showCustomToast(context,"تم حذف الموظف بنجاح","assets/icons/check_c.webp",AppColors.c368);
        getEmployees(
            context, "0",true);
      } else {
        setDeleteLoading(false);
        if (deleteSubsectionsResponse["data"] is Map &&
            deleteSubsectionsResponse["data"]["message"] != null) {
          showCustomToast(context,deleteSubsectionsResponse["data"]["message"],"assets/icons/alert-circle.webp",AppColors.c999);
        } else {
          print(deleteSubsectionsResponse["data"]);
          showCustomToast(context,"حدثت مشكله ما حاول مره اخري","assets/icons/alert-circle.webp",AppColors.c999);
        }
      }
    }).catchError((error) {
      if (error is DioException) {
        print('DioError in requestOrder: ${error.message}');
        setDeleteLoading(false);
        showCustomToast(context,"حدثت مشكله ما حاول مره اخري","assets/icons/alert-circle.webp",AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setDeleteLoading(false);
        showCustomToast(context,"حدثت مشكله ما حاول مره اخري","assets/icons/alert-circle.webp",AppColors.c999);
      }
    });
  }

  Future updateEmployeeStatus(BuildContext context, String employeeId, String status) async {
    setUpdateStatusLoading(true);
    await Provider.of<ApiServicesViewModel>(context, listen: false)
        .updateData(apiUrl: "$baseUrl/api/v1/employees/$employeeId",
        headers: {
          'Authorization':
          Provider.of<UserViewModel>(context, listen: false).userToken
        },data: {
          "status" : status
        })
        .then((deleteSubsectionsResponse) {
      if (deleteSubsectionsResponse["status"] == "success") {
        setUpdateStatusLoading(false);
        Navigator.pop(context);
        if(status == "ACTIVE") {
          showCustomToast(context,"تم الغاء تعليق الموظف بنجاح","assets/icons/check_c.webp",AppColors.c368);
        } else {
          showCustomToast(context,"تم تعليق الموظف بنجاح","assets/icons/check_c.webp",AppColors.c368);
        }
        getEmployees(
            context, "0",true);
      } else {
        setUpdateStatusLoading(false);
        if (deleteSubsectionsResponse["data"] is Map &&
            deleteSubsectionsResponse["data"]["message"] != null) {
          showCustomToast(context,deleteSubsectionsResponse["data"]["message"],"assets/icons/alert-circle.webp",AppColors.c999);
        } else {
          print(deleteSubsectionsResponse["data"]);
          showCustomToast(context,"حدثت مشكله ما حاول مره اخري","assets/icons/alert-circle.webp",AppColors.c999);
        }
      }
    }).catchError((error) {
      if (error is DioException) {
        print('DioError in requestOrder: ${error.message}');
        setUpdateStatusLoading(false);
        showCustomToast(context,"حدثت مشكله ما حاول مره اخري","assets/icons/alert-circle.webp",AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setUpdateStatusLoading(false);
        showCustomToast(context,"حدثت مشكله ما حاول مره اخري","assets/icons/alert-circle.webp",AppColors.c999);
      }
    });
  }


}