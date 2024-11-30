import 'package:dio/dio.dart';
import 'package:tabee3_flutter/app/config/auth_inteceptor.dart';
import 'package:tabee3_flutter/app/data/common/common_variables.dart';

class DioClient {
  static Dio get DIO_CLIENT {
    // Dio dio = Dio();
    // dio.options.baseUrl = CommonVariables.settings.read(BASE_URL);
    // dio.options.connectTimeout = 50000; //50s
    // dio.options.receiveTimeout = 50000; //50s
    // dio.options.contentType = "application/json";
    //
    // dio.options.headers = {
    //   "Content-Type": "application/json",
    // };

    BaseOptions _baseOptions = BaseOptions(
        receiveTimeout: Duration(seconds: 50000),
        connectTimeout: Duration(seconds: 50000), //receiveDataWhenStatusError: true,
        followRedirects: false,
        contentType:"application/json" ,
        headers: {"Content-Type": "application/json"},

      //  validateStatus: (status) {return status !> 0;} ,
        baseUrl:CommonVariables.settings.read(BASE_URL)
    );

    Dio _dio = Dio(_baseOptions);
    _dio.interceptors.add(AuthInterceptor());
    return _dio;
  }
}
