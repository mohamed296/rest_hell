import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "",
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData(
      {required url, Map<String, dynamic>? query}) async {
    return await dio!.get(url);
  }

  static Future<Response> postData(
      {required url, required Map<String, dynamic> data}) async {
    return await dio!.post(url, data: data);
  }

  static Future<Response> putData(
      {required url, required Map<String, dynamic> data}) async {
    return await dio!.put(url, data: data);
  }
}
