import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:menu_dashboard/model/size_model/size_model.dart';
import 'package:provider/provider.dart';

import '../components/custom_circular_progress_indicator.dart';
import '../components/custom_title.dart';
import '../components/custom_toast.dart';
import '../utilities/colors.dart';
import '../utilities/constants.dart';
import 'api_services_view_model.dart';
import 'general_view_model.dart';
import 'product_view_model.dart';
import 'user_view_model.dart';

class AddProductSizeViewModel with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController productName = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController price = TextEditingController();
  List<SizeModel> mainSizes = [];
  int totalSizes = 0;
  bool loading = false;
  bool loadingMainSizes = false;
  int currentIndex = 1;
  bool loadingOtherMainSizes = false;

  clearData() {
    name.clear();
    price.clear();
    productName.clear();
    notifyListeners();
  }

  assignData(String name) {
    productName.text = name;
    notifyListeners();
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  void setLoadingMainSizes(bool value) {
    loadingMainSizes = value;
    notifyListeners();
  }

  void setLoadingOtherMainSizes(bool value) {
    loadingOtherMainSizes = value;
    notifyListeners();
  }

  Future addSizeAndPrice(BuildContext context,String productId) async {
    if (formKey.currentState!.validate()) {
      setLoading(true);
      formKey.currentState!.save();
      await Provider.of<ApiServicesViewModel>(context, listen: false)
          .postData(apiUrl: "$baseUrl/api/v1/items", headers: {
        'Authorization':
            'Bearer ${Provider.of<UserViewModel>(context, listen: false).userToken}'
      }, data: {}).then((getSubsectionsResponse) {
        print(getSubsectionsResponse);
        if (getSubsectionsResponse["status"] == "success") {
          loading = false;
          Provider.of<GeneralViewModel>(context, listen: false)
              .updateSelectedIndex(index: SIZES_INDEX);
          notifyListeners();
        } else {
          setLoading(false);
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
          setLoading(false);
          print('DioError in requestOrder: ${error.message}');
          showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
              "assets/icons/alert-circle.webp", AppColors.c999);
        } else {
          setLoading(false);
          // Handle other errors
          print('Error in requestOrder: $error');
          showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
              "assets/icons/alert-circle.webp", AppColors.c999);
        }
      });
    }
  }

  Future getMainSizes(
    BuildContext context,
    String page,
  ) async {
    setLoadingMainSizes(true);
    await Provider.of<ApiServicesViewModel>(context, listen: false)
        .getData(apiUrl: "$baseUrl/api/v1/items/subcategory?page=$page&size=10")
        .then((getItemsResponse) {
      if (getItemsResponse["status"] == "success") {
        mainSizes = [];
        for (int i = 0; i < getItemsResponse["data"]["content"].length; i++) {
          mainSizes
              .add(SizeModel.fromJason(getItemsResponse["data"]["content"][i]));
        }
        totalSizes = getItemsResponse["data"]["totalElements"];
        loadingMainSizes = false;
        notifyListeners();
        showDialog<String>(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, setState) => SimpleDialog(
                title: const Text('اختر الحجم', textAlign: TextAlign.center),
                children: mainSizes.isNotEmpty
                    ? [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              ...mainSizes.map((mainSize) {
                                return SimpleDialogOption(
                                  onPressed: () {
                                    setState(() {
                                      name.text = mainSize.name;
                                    });
                                    Navigator.pop(
                                      context,
                                    );
                                  },
                                  child: Text(mainSize.name),
                                );
                              }),
                              if (mainSizes.length != totalSizes)
                                TextButton(
                                  onPressed: () {
                                    getOtherMainSizes(
                                        context, currentIndex.toString());
                                  },
                                  child: loadingOtherMainSizes
                                      ? const CustomCircularProgressIndicator(
                                      iosSize: 20, color: AppColors.mainColor)
                                      : const CustomTitle(
                                    text: 'تحميل المزيد',
                                    fontSize: 16,
                                    color: AppColors.mainColor,
                                  ),
                                )
                            ],
                          ),
                        )
                      ]
                    : [
                        const CustomTitle(
                          text: 'لا توجد احجام',
                          fontSize: 16,
                          color: AppColors.mainColor,
                        ),
                      ],
              ),
            );
          },
        );
      } else {
        setLoadingMainSizes(false);
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
        setLoadingMainSizes(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setLoadingMainSizes(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      }
    });
  }

  Future getOtherMainSizes(
    BuildContext context,
    String page,
  ) async {
    setLoadingOtherMainSizes(true);
    await Provider.of<ApiServicesViewModel>(context, listen: false)
        .getData(apiUrl: "$baseUrl/api/v1/items/subcategory?page=$page&size=10")
        .then((getItemsResponse) {
      if (getItemsResponse["status"] == "success") {
        for (int i = 0; i < getItemsResponse["data"]["content"].length; i++) {
          mainSizes
              .add(SizeModel.fromJason(getItemsResponse["data"]["content"][i]));
        }
        totalSizes = getItemsResponse["data"]["totalElements"];
        if (getItemsResponse["data"]["content"].isNotEmpty) {
          currentIndex++;
        }
        loadingOtherMainSizes = false;
        notifyListeners();
      } else {
        setLoadingOtherMainSizes(false);
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
        setLoadingOtherMainSizes(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      } else {
        // Handle other errors
        print('Error in requestOrder: $error');
        setLoadingOtherMainSizes(false);
        showCustomToast(context, "حدثت مشكله ما حاول مره اخري",
            "assets/icons/alert-circle.webp", AppColors.c999);
      }
    });
  }

}
