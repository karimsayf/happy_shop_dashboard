import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_toast.dart';
import '../utilities/colors.dart';
import '../utilities/constants.dart';
import 'api_services_view_model.dart';
import 'general_view_model.dart';
import 'user_view_model.dart';

class AddBannerViewModel with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PlatformFile? file;
  bool loading = false;

  clearData() {
    file = null;
    notifyListeners();
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  Future addBanner(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setLoading(true);
      formKey.currentState!.save();
      await Provider.of<GeneralViewModel>(context, listen: false)
          .uploadImage(context,file!)
          .then((photoResponse) async{
        print(photoResponse);
        if (photoResponse["status"] == "success") {
          await Provider.of<ApiServicesViewModel>(context, listen: false)
              .postData(
              apiUrl: "$baseUrl/api/v1/banner",
              headers: {
                'Authorization':
                Provider.of<UserViewModel>(context, listen: false).userToken
              },
              data: {
                "photo" : photoResponse['data']['filePath']
              })
              .then((getBannersResponse) {
            print(getBannersResponse);
            if (getBannersResponse["status"] == "success") {
              loading = false;
              showCustomToast(context, "تم اضافة القسم بنجاح",
                  "assets/icons/check_c.webp", AppColors.c368);
              Provider.of<GeneralViewModel>(context, listen: false)
                  .updateSelectedIndex(index: BANNERS_INDEX);
              notifyListeners();
            } else {
              setLoading(false);
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
        } else {
          setLoading(false);
          if (photoResponse["data"] is Map &&
              photoResponse["data"]["message"] != null) {
            showCustomToast(context, photoResponse["data"]["message"],
                "assets/icons/alert-circle.webp", AppColors.c999);
          } else {
            print(photoResponse["data"]);
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
