import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:menu_dashboard/view_model/product_sizes_view_model.dart';
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
import 'product_view_model.dart';
import 'user_view_model.dart';

class AddProductColorViewModel with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController productName = TextEditingController();
  final TextEditingController color = TextEditingController();
  int totalSizes = 0;
  bool loading = false;
  bool loadingMainSizes = false;
  int currentIndex = 1;
  bool loadingOtherMainSizes = false;

  clearData() {
    color.clear();
    productName.clear();
    currentIndex = 1;
    totalSizes = 0;
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


  Future addColorAndPrice(BuildContext context,String productId) async {
    if (formKey.currentState!.validate()) {
      setLoading(true);
      formKey.currentState!.save();
      await Provider.of<ApiServicesViewModel>(context, listen: false)
          .postData(apiUrl: "$baseUrl/api/v1/product/$productId/colors", headers: {
        'Authorization':
            Provider.of<UserViewModel>(context, listen: false).userToken
      }, data: {
        'color': color.text,
      }).then((getSubsectionsResponse) {
        print(getSubsectionsResponse);
        if (getSubsectionsResponse["status"] == "success") {
          loading = false;
          showCustomToast(context, "تم اضافة اللون بنجاح",
              "assets/icons/check_c.webp", AppColors.c368);
          Provider.of<GeneralViewModel>(context, listen: false)
              .updateSelectedIndex(index: COLORS_INDEX);
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

}
