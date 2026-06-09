import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../utils/app_constants.dart';
import '../../utils/shared_prefrences.dart';

class ApiService<T> {
  // A generic function for making HTTP requests
  Future<T> makeRequest({
    required String method, // HTTP method: GET, POST, etc.
    required String url, // API endpoint
    Map<String, String>? headers, // Optional headers
    dynamic body, // Optional body (for POST, PUT, etc.)
    Map<String, dynamic>? queryParams, // Optional query parameters
    T? data,
    BuildContext? context,
    T Function(Map<String, dynamic>)?
        fromJson, // Function to convert the JSON response into the model
  }) async {
    print('in makeRequest ');
    // Prepare the query string if there are query parameters
    String queryString = '';
    if (queryParams != null) {
      queryString = Uri(queryParameters: queryParams).query;
      url = '$url?$queryString';
    }

    // Set headers and default to JSON if not provided
    headers ??= {
      'Content-Type': 'application/json',
      'X-localization': MySharedPreferences.language,
      'Authorization': MySharedPreferences.accessToken,

    };



    // Make the request based on the method
    http.Response response;
    String errorMessage = AppConstants.failedMessage;
    try {
      switch (method.toUpperCase()) {
        case 'GET':
         response = await http.get(Uri.parse(url), headers: headers);
          break;
        case 'POST':
          response = await http.post(Uri.parse(url),
              headers: headers, body: jsonEncode(body));
          break;
        case 'PUT':
          response = await http.put(Uri.parse(url),
              headers: headers, body: jsonEncode(body));
          break;
        case 'DELETE':
          response = await http.delete(Uri.parse(url),
              headers: headers, body: jsonEncode(body));
          break;
        default:
          throw Exception("HTTP method not supported");
      }
      print('response.statusCode ${response.statusCode}');
      print('response.body ${response.body}');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonResponse = json.decode(response.body);
        return fromJson!(jsonResponse);
      } else if (response.statusCode == 500) {
                final jsonResponse = json.decode(response.body);

        final errorResponse = json.decode(response.body);
        print(errorResponse);

  errorMessage =
            errorResponse['msg'] ?? AppConstants.failedMessage;
            print(errorResponse['msg']); 
// throw Exception(errorMessage);
 return fromJson!(jsonResponse);
      } else {
        throw AppConstants().showMsgToast(
          context,
          msg: errorMessage,
        );
      }
    } catch (error) {

      if (error.toString().contains("Failed host lookup: 'waytodoctor.net'")) {
        throw "Unable to connect to the server. Please check your internet connection.".tr;
      }
      throw AppConstants().showMsgToast(
        context,
        msg: AppConstants.failedMessage,
      );
    }
  }
}
