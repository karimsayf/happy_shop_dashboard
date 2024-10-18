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

class EditBannerViewModel with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PlatformFile? file;
  bool loading = false;
  String? photoNetwork;
  String? bannerId;

  clearData() {
    file = null;
    photoNetwork = null;
    bannerId = null;
    notifyListeners();
  }

  assignData(String imgUrl , String id){
    photoNetwork = imgUrl;
    bannerId = id;
    notifyListeners();
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  Future editBanner(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setLoading(true);
      formKey.currentState!.save();
      if(file != null) {
        print("file is found");
        await Provider.of<GeneralViewModel>(context, listen: false)
            .uploadImage(context,file!)
            .then((photoResponse) async{
          print(photoResponse);
          if (photoResponse["status"] == "success") {
            await Provider.of<ApiServicesViewModel>(context, listen: false)
                .updateData(
              apiUrl: "$baseUrl/api/v1/banner/$bannerId",
              headers: {
                'Authorization':
                Provider
                    .of<UserViewModel>(context, listen: false)
                    .userToken
              },
              data: {
                "photo" : photoResponse['data']['filePath']
              },)
                .then((getSubsectionsResponse) {
              if (getSubsectionsResponse["status"] == "success") {
                loading = false;
                showCustomToast(context, "تم تعديل القسم بنجاح",
                    "assets/icons/check_c.webp", AppColors.c368);
                Provider.of<GeneralViewModel>(context, listen: false)
                    .updateSelectedIndex(index: BANNERS_INDEX);
                notifyListeners();
              } else {
                setLoading(false);
                if (getSubsectionsResponse["data"] is Map &&
                    getSubsectionsResponse["data"]["message"] != null) {
                  showCustomToast(
                      context, getSubsectionsResponse["data"]["message"],
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
      } else {
        print("file not found");
        await Provider.of<ApiServicesViewModel>(context, listen: false)
            .updateData(
          apiUrl: "$baseUrl/api/v1/banner/$bannerId",
          headers: {
            'Authorization':
            Provider
                .of<UserViewModel>(context, listen: false)
                .userToken
          },
          data: {
            "photo" : photoNetwork
          },)
            .then((getSubsectionsResponse) {
          if (getSubsectionsResponse["status"] == "success") {
            loading = false;
            showCustomToast(context, "تم تعديل القسم بنجاح",
                "assets/icons/check_c.webp", AppColors.c368);
            Provider.of<GeneralViewModel>(context, listen: false)
                .updateSelectedIndex(index: BANNERS_INDEX);
            notifyListeners();
          } else {
            setLoading(false);
            if (getSubsectionsResponse["data"] is Map &&
                getSubsectionsResponse["data"]["message"] != null) {
              showCustomToast(
                  context, getSubsectionsResponse["data"]["message"],
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

}