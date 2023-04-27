import 'dart:convert';

import 'package:dio/dio.dart';
import '../../resources/resources.dart';
import '../../services/services.dart';

class NetworkService {
  final String tag = 'NetworkSevice';
  final String _baseUrl = ResourcesNetwork().baseUrl;

  late Dio _dio;
  late BaseOptions dioOptions;

  NetworkService() {
    /// init dio option first
    initDioOptions();

    /// then init dio with dio options
    initDio();
  }

  void initDioOptions() {
    dioOptions = BaseOptions()..baseUrl = _baseUrl;
    dioOptions.validateStatus = (value) {
      return value! < 500;
    };
  }

  void initDio() {
    _dio = Dio(dioOptions);
    _dio.interceptors.add(NetworkInterceptor());
  }

  Future<Response> getData({
    required String path,
    Map<String, String>? header,
    Map<String, String>? params,
  }) async {
    /// getData with parameters (path, header, params)
    /// [header] custom header
    try {
      return await _dio.get(
        path,
        options: Options(headers: header),
        queryParameters: params,
      );
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Response> postData({
    required String path,
    Map<String, String>? header,
    dynamic data,
  }) async {
    /// getData with parameters (path, header, params)
    /// [header] custom header
    try {
      return await _dio.post(
        path,
        options: Options(headers: header),
        data: data,
      );
    } on DioError catch (ex) {
      throw Exception(json.decode(ex.response.toString())["error"]);
    }
  }
}
