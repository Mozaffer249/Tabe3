import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends InterceptorsWrapper {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    //  SharedPreferences prefs = await SharedPreferences.getInstance();
     // var token = prefs.getString("token");
    //  if(token !=null)  options.headers["Authorization"] = "Bearer " + token;
      debugPrint("Request url : " + options.uri.toString() + " , data is : " + options.data.toString() + " , headers : " + options.headers.toString());
      return super.onRequest(options,handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("Response is : " + response.data.toString() + " , headers : " + response.headers.toString());
       return super.onResponse(response, handler);
  }
}

