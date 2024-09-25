import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_circular_progress_indicator.dart';
import '../components/custom_title.dart';
import '../components/custom_toast.dart';
import '../model/main_size_model/main_size_model.dart';
import '../model/product_size_model/product_size_model.dart';
import '../utilities/colors.dart';
import '../utilities/constants.dart';
import 'api_services_view_model.dart';
import 'general_view_model.dart';
import 'product_sizes_view_model.dart';
import 'product_view_model.dart';
import 'user_view_model.dart';

class EditProductSizeViewModel with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController productName = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController price = TextEditingController();
  List<MainSizeModel> mainSizes = [];
  int totalSizes = 0;
  bool loading = false;
  bool loadingMainSizes = false;
  int currentIndex = 1;
  bool loadingOtherMainSizes = false;
  String? mainSizeId;
  String? productSizeId;

  clearData() {
    name.clear();
    price.clear();
    productName.clear();
    mainSizes = [];
    currentIndex = 1;
    mainSizeId = null;
    totalSizes = 0;
    productSizeId = null;
    notifyListeners();
  }

  assignData(ProductSizeModel size,String pName){
    name.text = size.size;
    price.text = size.price;
    mainSizeId = size.sizeId;
    productName.text = pName;
    productSizeId = size.id;
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

  Future editSizeAndPrice(BuildContext context,String productId) async {
    if (formKey.currentState!.validate()) {
      setLoading(true);
      formKey.currentState!.save();
      print(productSizeId);
      List data = Provider.of<ProductViewModel>(context,listen: false).productSizes;
      final int index = data.indexWhere((element) {
        print('here element');
        print(element);
        return element['_id'] == productSizeId;
      },);
      data.removeAt(index);
      data.add({
        "sizeId": mainSizeId,
        "name": name.text,
        "price": price.text.trim()
      });
      await Provider.of<ApiServicesViewModel>(context, listen: false)
          .updateData(apiUrl: "$baseUrl/api/v1/product/$productId", headers: {
        'Authorization':
        Provider.of<UserViewModel>(context, listen: false).userToken
      }, data: {
        "sizes":[
          ...data.map((size)=>
          {
            "sizeId": size['sizeId'],
            "name": size['name'],
            "price": size['price'],
          }),
        ]
      }).then((getSubsectionsResponse) {
        print(getSubsectionsResponse);
        if (getSubsectionsResponse["status"] == "success") {
          loading = false;
          showCustomToast(context, "تم اضافة الحجم و السعر بنجاح",
              "assets/icons/check_c.webp", AppColors.c368);
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
        .getData(apiUrl: "$baseUrl/api/v1/size?page=$page&size=10", headers: {
      'Authorization':
      Provider.of<UserViewModel>(context, listen: false).userToken
    },)
        .then((getItemsResponse) {
      if (getItemsResponse["status"] == "success") {
        mainSizes = [];
        for (int i = 0; i < getItemsResponse["data"]["size"].length; i++) {
          mainSizes
              .add(MainSizeModel.fromJason(getItemsResponse["data"]["size"][i]));
        }
        totalSizes = getItemsResponse["data"]["totalSize"];
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
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...mainSizes.map((mainSize) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                name.text = mainSize.size;
                                mainSizeId = mainSize.id;
                              });
                              Navigator.pop(
                                context,
                              );
                            },
                            child: Row(
                              children: [
                                CustomTitle(
                                  text: mainSize.size,
                                  fontSize: 16,
                                  color: AppColors.c016,
                                )
                              ],
                            ),
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
                  const Center(
                    child: CustomTitle(
                      text: 'لا توجد احجام',
                      fontSize: 16,
                      color: AppColors.c016,
                    ),
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
        .getData(apiUrl: "$baseUrl/api/v1/size?page=$page&size=10", headers: {
      'Authorization':
      Provider.of<UserViewModel>(context, listen: false).userToken
    },)
        .then((getItemsResponse) {
      if (getItemsResponse["status"] == "success") {
        for (int i = 0; i < getItemsResponse["data"]["size"].length; i++) {
          mainSizes
              .add(MainSizeModel.fromJason(getItemsResponse["data"]["size"][i]));
        }
        totalSizes = getItemsResponse["data"]["totalSize"];
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