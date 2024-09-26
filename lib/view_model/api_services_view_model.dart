import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ApiServicesViewModel with ChangeNotifier {
  Dio dio = Dio(
      BaseOptions(
        validateStatus: (status) => true,
      )
  );

  Future<Map<String, dynamic>> getData({required String apiUrl,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers}) async {
    Response response = await dio.get(apiUrl,
        queryParameters: queryParameters, options: Options(headers: headers));
    print(response.data);
    if (response.statusCode == 200) {
      return {"status": "success", "data": response.data};
    } else {
      return {"status": "failed", "data": response.data};
    }
  }

  Future<Map<String, dynamic>> postData({
    required String apiUrl,
    Map<String, dynamic>? data,
    FormData? formData,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {


    Response response =
    await dio.post(apiUrl, data: data ?? formData,
        options: Options(headers: headers ),
        queryParameters: queryParameters);
    if (response.statusCode == 200) {
      return {"status": "success", "data": response.data};
    } else {
      return {"status": "failed", "data": response.data};
    }
  }


  Future<Map<String, dynamic>> updateData({
    required String apiUrl,
    Map<String, dynamic>? data,
    FormData? formData,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? parameters,

  }) async {
    Response response =
    await dio.put(apiUrl, data: data ?? formData, options: Options(headers: headers),queryParameters: parameters);
    print(response.data);

    if (response.statusCode == 200) {
      return {"status": "success", "data": response.data};
    } else {
      return {"status": "failed", "data": response.data};
    }
  }


  Future<Map<String, dynamic>> deleteData({
    required String apiUrl,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response response =
    await dio.delete(apiUrl, data: data, options: Options(headers: headers));
    print(response.data);
    if (response.statusCode == 200) {
      return {"status": "success", "data": response.data};
    } else {
      return {"status": "failed", "data": response.data};
    }
  }

}