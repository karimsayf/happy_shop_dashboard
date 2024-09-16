import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../utilities/constants.dart';
import 'api_services_view_model.dart';

class UserViewModel with ChangeNotifier {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  String userToken = "";
  String userId = "";
  String name = "";

// Function to save the User Data to Flutter Secure Storage
  Future<void> saveUserDataToFSS(String userToken, String userId,
      String name) async {
    await storage.write(key: "userToken", value: userToken);
    await storage.write(key: "userId", value: userId);
    await storage.write(key: "name", value: name);
  }

  // Function to load the Data from Flutter Secure Storage
  Future<void> loadUserDataFromFSS() async {
    userToken = (await storage.read(key: "userToken")) ?? "";
    userId = (await storage.read(key: "userId")) ?? "";
    name = (await storage.read(key: "name")) ?? "";
    notifyListeners();
  }

  //delete userdata
  Future deleteUserData() async {
    await storage.deleteAll();
    userToken = "";
    userId = "";
    name = "";
    notifyListeners();
  }


  Future signIn(BuildContext context, String username, String password) async {
    dynamic customerResponse;
    await Provider.of<ApiServicesViewModel>(context, listen: false).postData(
        apiUrl: "$baseUrl/api/v1/users/login",
        data: {
          "username": username,
          "password": password
        }
    ).then((response) {
      print('RESPONSe');
      print(response);
      customerResponse = response;
    });
    return customerResponse;
  }


  Future signOut(BuildContext context) async {
    dynamic customerResponse;
    await Provider.of<ApiServicesViewModel>(context, listen: false).postData(
        apiUrl: "$baseUrl/api/v1/users/logout",
        headers: {
          'Authorization': 'Bearer $userToken'
        }
    ).then((response) {
      customerResponse = response;
    });
    return customerResponse;
  }


}