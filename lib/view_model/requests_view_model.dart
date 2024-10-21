import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:menu_dashboard/utilities/size_utility.dart';
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
  List<Order> requests = [];
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
  bool loadingRequestDetails = false;
  List<ProductOrder> ordersDetails = [];

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

  void updateSelectedRecord(int value) {
    selectedRequestRecord = value;
    notifyListeners();
  }

  Future getRequestsHome(
      BuildContext context, String status, String page) async {
    setRequestsHomeLoading(true);
    clearRequests();
    clearData();
    await Provider.of<ApiServicesViewModel>(context, listen: false).getData(
        apiUrl: "$baseUrl/api/v1/order?$status&page=$page&size=10",
        headers: {
          'Authorization':
              Provider.of<UserViewModel>(context, listen: false).userToken
        }).then((getSubsectionsResponse) {
      clearRequests();
      clearData();
      if (getSubsectionsResponse["status"] == "success") {
        for (int i = 0;
            i < getSubsectionsResponse["data"]["orders"].length;
            i++) {
          requests.add(Order.fromJson(
              getSubsectionsResponse["data"]["orders"][i]));
        }
        if (requests.isEmpty) {
          requestsEmpty = true;
        } else {
          requestsEmpty = false;
        }
        totalRequests = getSubsectionsResponse["data"]["totalOrders"];
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

  Future getRequests(
      BuildContext context, String status, String page, bool clear) async {
    setRequestsLoading(true);
    clearRequests();
    if (clear) {
      clearData();
    }
    await Provider.of<ApiServicesViewModel>(context, listen: false).getData(
        apiUrl: "$baseUrl/api/v1/order?$status&page=$page&size=10",
        headers: {
          'Authorization':
              Provider.of<UserViewModel>(context, listen: false).userToken
        }).then((getSubsectionsResponse) {

      print(getSubsectionsResponse);
      if (getSubsectionsResponse["status"] == "success") {
        clearRequests();
        requests = getSubsectionsResponse["data"]["orders"]
            .map<Order>((e) => Order.fromJson(e))
            .toList();
        if (requests.isEmpty) {
          requestsEmpty = true;
        } else {
          requestsEmpty = false;
        }
        totalRequests = getSubsectionsResponse["data"]["totalOrders"];
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

  Future updateRequestStatus(
      BuildContext context, String orderId, String status) async {
    dynamic updateOrderStatusResponse;
    await Provider.of<ApiServicesViewModel>(context, listen: false).updateData(
      apiUrl: "$baseUrl/api/v1/order/$orderId",
      data: {"status": status},
      headers: {
        'Authorization':
            Provider.of<UserViewModel>(context, listen: false).userToken
      },
    ).then((response) {
      updateOrderStatusResponse = response;
    });
    return updateOrderStatusResponse;
  }

  Future rejectOrder(
      BuildContext context, String orderId) async {
    setRejectLoading(true);
    await updateRequestStatus(context, orderId, "CANCELLED")
        .then((updateOrderStatusResponse) {
      if (updateOrderStatusResponse["status"] == "success") {
        setRejectLoading(false);
        Navigator.pop(context);
        showCustomToast(context, "تم رفض الطلب بنجاح",
            "assets/icons/check_c.webp", AppColors.c368);
        getRequests(context, "status=PROGRESSING", "0", true);
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

  Future approveOrder(
      BuildContext context, String orderId) async {
    setApproveLoading(true);
    await updateRequestStatus(context, orderId, "DONE")
        .then((updateOrderStatusResponse) {
      if (updateOrderStatusResponse["status"] == "success") {
        setApproveLoading(false);
        Navigator.pop(context);
        showCustomToast(context, "تم تاكيد الطلب بنجاح",
            "assets/icons/check_c.webp", AppColors.c368);
        getRequests(context, "status=PROGRESSING", "0", true);
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

  Future getRequestDetails(BuildContext context, List<ProductOrder> products) async {
    loadingRequestDetails = true;
    await Future.delayed(const Duration(milliseconds: 350));
    ordersDetails = [];
    ordersDetails =
        products.map((e) =>e).toList();
    loadingRequestDetails = false;
    notifyListeners();
    showCustomDialog(context, content: StatefulBuilder(
      builder: (context, setState) {
        return SizedBox(
          width: 400,
          height: 550,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.mainColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(50)),
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: AppColors.c555,
                                borderRadius: BorderRadius.circular(50)),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: AppColors.mainColor.withOpacity(0.11),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Center(
                                child: Image.asset(
                                  "assets/icons/document.webp",
                                  scale: 3.5,
                                  color: AppColors.mainColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const CustomTitle(
                          text: "تفاصيل الطلب",
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.c016,
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close_rounded,
                        size: 25,
                        color: AppColors.c111,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ...ordersDetails.mapIndexed(
                  (index, product) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 20,left: 5,right: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.c016.withOpacity(0.05),
                            spreadRadius: 3,
                            blurRadius: 7,
                          ),
                        ],
                        color: AppColors.c555,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CustomTitle(
                                text: "اسم المنتج :",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.c912,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                child: CustomTitle(
                                  text: product.productName,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.c016,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomTitle(
                                text: "صورة المنتج :",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.c912,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border:
                                  Border.all(width: 1, color: AppColors.c912),
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: NetworkImage(
                                    "$baseUrl/uploads/${product.productPhoto}"),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            height: 180,
                            width: getSize(context).width,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomTitle(
                                text: "مكونات المنتج :",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.c912,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTitle(
                            text: product.productComponents,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: AppColors.c016,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomTitle(
                                text: "وصف المنتج :",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.c912,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTitle(
                            text: product.productDesc,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: AppColors.c016,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CustomTitle(
                                text: "الكمية :",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.c912,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                child: CustomTitle(
                                  text: product.quantity.toString(),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.c016,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CustomTitle(
                                text: "الحجم :",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.c912,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                child: CustomTitle(
                                  text: product.productSize ??"لا يوجد حجم",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.c016,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CustomTitle(
                                text: "اللون :",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.c912,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                child: CustomTitle(
                                  text: product.productColor ??"لا يوجد لون",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.c016,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CustomTitle(
                                text: "السعر الأجمالي :",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.c912,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                child: CustomTitle(
                                  text: product.totalPrice.toString(),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.c016,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}
