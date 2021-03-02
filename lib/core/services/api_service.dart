import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:money_converter/core/models/api_response.dart';

class APIService {
  static const String BASE_URL = "http://api.currencylayer.com";
  static const String API_KEY = "48c5af56eb837f0875c0a16d96b0a2cf";

  Future<ApiResponse> convert() async {
    try {
      var response = await http.get("$BASE_URL/live?access_key=$API_KEY");
      //print("response: ${response.body}");
      if (response.statusCode == 200) {
        print("${response.body}");
        var res = jsonDecode(response.body);
        if (res['success'] == true) {
          var apiResponse = ApiResponse.fromMap(res);
          return apiResponse;
        }
      }
      return null;
    } catch (e) {
      print("APIService Class Error: $e");
      return null;
    }
  }
}
