import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/constants.dart';
import 'api_services_view_model.dart';
import 'user_view_model.dart';
class GeneralViewModel with ChangeNotifier {
  int selectedIndex = 0;
  String mainTitle = "الرئيسية";
  bool printInvoiceWithLogo = false;
  int settingsSelectedIndex = 0;


  updateMainScreen(int index,String title) {
    selectedIndex = index;
    mainTitle = title;
    notifyListeners();
  }

  updateSelectedIndex({required int index}){
    selectedIndex = index;
    notifyListeners();
  }

  updateSettingsSelectedIndex({required int index}){
    settingsSelectedIndex = index;
    notifyListeners();
  }

  updatePrintInvoice (bool val) async{
    printInvoiceWithLogo = val;
    await savePrintInvoiceWithLogoToPreferences(printInvoiceWithLogo);
    notifyListeners();
  }


  // Function to save printInvoiceWithLogo to shared preferences
  Future<void> savePrintInvoiceWithLogoToPreferences(bool printInvoice) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('printInvoice', printInvoice);
  }

  // Function to retrieve the ToIntro from shared preferences
  Future<void> loadPrintInvoiceWithLogoFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? print = prefs.getBool('printInvoice');
    if (print != null) {
      printInvoiceWithLogo = print;
      notifyListeners();
    }
  }

  Future uploadImage(BuildContext context, PlatformFile file) async {
    dynamic uploadImageResponse;
    Uint8List fileBytes = await file.xFile.readAsBytes();
    await Provider.of<ApiServicesViewModel>(context, listen: false).postData(
        apiUrl: "$baseUrl/api/v1/upload",
        formData: FormData.fromMap({
          'file':  MultipartFile.fromBytes(fileBytes,filename: file.xFile.name),
        }),
        headers: {
          "Authorization":
          Provider.of<UserViewModel>(context, listen: false).userToken,
        }).then((response) {
      uploadImageResponse = response;
    });
    return uploadImageResponse;
  }

}