import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_dialog.dart';
import '../components/custom_title.dart';
import '../components/custom_toast.dart';
import '../model/request_model/request_model.dart';
import '../utilities/colors.dart';
import '../utilities/constants.dart';
import 'api_services_view_model.dart';
import 'user_view_model.dart';

class RequestsViewModel with ChangeNotifier {
  int selectedRequestRecord = 0;
  List<RequestModel> requests = [];
  int totalRequests = 0;
  bool isRequestsHomeLoading = true;
  bool isRequestsLoading = true;
  bool requestsEmpty = false;
  final int rowsPerPage = 10;
  int currentPage = 0;
  int firstNum = 1;
  int lastNum = 10;
  bool rejecting = false;
  bool approving = false;
  bool confirming = false;
  bool progressing = false;
  bool underReviewing = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController reasonController = TextEditingController();
  Map<String, dynamic> selectedStatus = {};
  bool loadingRequestDetails = false;


  void setPage(int page) {
    currentPage = page;
    notifyListeners();
  }

  void setRequestsHomeLoading(bool value) {
    isRequestsHomeLoading = value;
    notifyListeners();
  }

  void setRequestsLoading(bool value) {
    isRequestsLoading = value;
    notifyListeners();
  }

  void setRequestDetailsLoading(bool value) {
    loadingRequestDetails = value;
    notifyListeners();
  }

  void setApproveLoading(bool value) {
    approving = value;
    notifyListeners();
  }

  void setRejectLoading(bool value) {
    rejecting = value;
    notifyListeners();
  }

  void setConfirmLoading(bool value) {
    confirming = value;
    notifyListeners();
  }

  void setProgressLoading(bool value) {
    progressing = value;
    notifyListeners();
  }

  void setUnderReviewing(bool value) {
    underReviewing = value;
    notifyListeners();
  }

  void clearRequests() {
    requests.clear();
    notifyListeners();
  }

  void clearData() {
    currentPage = 0;
    firstNum = 1;
    lastNum = 10;
    notifyListeners();
  }

  void updateSelectedFilter(Map<String, dynamic> value) {
    selectedStatus = value;
    notifyListeners();
  }

  void updateSelectedRecord(int value) {
    selectedRequestRecord = value;
    notifyListeners();
  }

  Future getRequestsHome(BuildContext context, String page) async {
    setRequestsHomeLoading(true);
    clearRequests();
    clearData();
    await Provider.of<ApiServicesViewModel>(context, listen: false)
        .getData(
        apiUrl: "$baseUrl/api/v1/orders?page=$page&size=10",
        headers: {
          'Authorization':
          'Bearer ${Provider.of<UserViewModel>(context, listen: false).userToken}'
        })
        .then((getSubsectionsResponse) {
      clearRequests();
      clearData();
      if (getSubsectionsResponse["status"] == "success") {
        for (int i = 0;
        i < getSubsectionsResponse["data"]["content"].length;
        i++) {
          requests.add(RequestModel.fromJason(
              getSubsectionsResponse["data"]["content"][i]));
        }
        if (requests.isEmpty) {
          requestsEmpty = true;
        } else {
          requestsEmpty = false;
        }
        totalRequests = getSubsectionsResponse["data"]["totalElements"];
        isRequestsLoading = false;
        isRequestsHomeLoading = false;
        notifyListeners();
      } else {
        setRequestsHomeLoading(false);
        setRequestsLoading(false);
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
        setRequestsLoading(false);
        setRequestsHomeLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setRequestsLoading(false);
        setRequestsHomeLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      }
    });
  }

  Future getRequests(BuildContext context, String page, bool clear) async {
    setRequestsLoading(true);
    clearRequests();
    if (clear) {
      clearData();
    }
    await Provider.of<ApiServicesViewModel>(context, listen: false)
        .getData(
        apiUrl: "$baseUrl/api/v1/orders?page=$page&size=10",
        headers: {
          'Authorization':
          'Bearer ${Provider.of<UserViewModel>(context, listen: false).userToken}'
        })
        .then((getSubsectionsResponse) {
      print(getSubsectionsResponse);
      if (getSubsectionsResponse["status"] == "success") {
          requests = getSubsectionsResponse["data"]["content"]
              .map<RequestModel>((e) => RequestModel.fromJason(e))
              .toList();
        if (requests.isEmpty) {
          requestsEmpty = true;
        } else {
          requestsEmpty = false;
        }
        totalRequests = getSubsectionsResponse["data"]["totalElements"];
        isRequestsLoading = false;
        notifyListeners();
      } else {
        setRequestsLoading(false);
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
        setRequestsLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setRequestsLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      }
    });
  }

  Future updateRequestStatus(BuildContext context, String orderId, String status,
      String rejectionReason) async {
    dynamic updateOrderStatusResponse;
    await Provider.of<ApiServicesViewModel>(context, listen: false).updateData(
      apiUrl:
      "$baseUrl/api/v1/orders/changeStatus/$orderId/?status=$status&reason=$rejectionReason",
      headers: {
        'Authorization':
        'Bearer ${Provider.of<UserViewModel>(context, listen: false).userToken}'
      },
    ).then((response) {
      updateOrderStatusResponse = response;
    });
    return updateOrderStatusResponse;
  }

  Future rejectOrder(BuildContext context, String orderId) async {
    setRejectLoading(true);
    formKey.currentState!.save();
    await updateRequestStatus(
        context, orderId, "REJECTED", reasonController.text.trim())
        .then((updateOrderStatusResponse) {
      if (updateOrderStatusResponse["status"] == "success") {
        setRejectLoading(false);
        Navigator.pop(context);
        showCustomToast(context, "تم رفض الطلب بنجاح",
            "assets/icons/check_c.webp", AppColors.c368);
        getRequests(
            context,
            "0",
            true);
      } else {
        setRejectLoading(false);
        if (updateOrderStatusResponse["data"] is Map &&
            updateOrderStatusResponse["data"]["message"] != null) {
          showCustomToast(context, updateOrderStatusResponse["data"]["message"],
              "assets/icons/alert-circle.webp", AppColors.c999);
        } else {
          print(updateOrderStatusResponse["data"]);
          showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
              "assets/icons/alert-circle.webp", AppColors.c999);
        }
      }
    }).catchError((error) {
      if (error is DioException) {
        print('DioError in requestOrder: ${error.message}');
        setRejectLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setRejectLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      }
    });
  }

  Future approveOrder(BuildContext context, String orderId) async {
    setApproveLoading(true);
    await updateRequestStatus(context, orderId, "COMPLETED", "")
        .then((updateOrderStatusResponse) {
      if (updateOrderStatusResponse["status"] == "success") {
        setApproveLoading(false);
        showCustomToast(context, "تم تاكيد الطلب بنجاح",
            "assets/icons/check_c.webp", AppColors.c368);
        getRequests(
            context,
            "0",
            true);
      } else {
        setApproveLoading(false);
        if (updateOrderStatusResponse["data"] is Map &&
            updateOrderStatusResponse["data"]["message"] != null) {
          showCustomToast(context, updateOrderStatusResponse["data"]["message"],
              "assets/icons/alert-circle.webp", AppColors.c999);
        } else {
          print(updateOrderStatusResponse["data"]);
          showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
              "assets/icons/alert-circle.webp", AppColors.c999);
        }
      }
    }).catchError((error) {
      if (error is DioException) {
        print('DioError in requestOrder: ${error.message}');
        setApproveLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setApproveLoading(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      }
    });
  }

}