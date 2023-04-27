import 'package:dio/dio.dart';

class NetworkInterceptor implements InterceptorsWrapper {
  static int i = 0;
  @override
  void onError(err, handler) async {
    return handler.next(err);
  }

  @override
  void onRequest(options, handler) async {
    i = 0;
    options.validateStatus = (status) {
      return true;
    };
    options.followRedirects = true;
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    i++;
    switch (response.statusCode) {
      case 401:
        await tokenExpired(response, handler);
        break;
      case 403:
      case 406:
        await userLogout(response, handler);
        break;
      default:
        return handler.next(response);
    }
  }

  Future<void> tokenExpired(
      Response response, ResponseInterceptorHandler handler) async {
    // try {
    // var refreshToken = await Datas().getString(Datas.refreshToken);

    // final resData = await ServiceUser().refreshTokenWithoutContextV2();
    // final model = ModelBaseApiV2.fromJson(resData.data);
    // if (model.success) {
    //   Datas().setString(Datas.token, model.data['token']);

    //   response.requestOptions.headers.addAll(
    //     {
    //       'Authorization': 'Bearer ${model.data['token']}}',
    //     },
    //   );

    final opts = Options(
      method: response.requestOptions.method,
      headers: response.requestOptions.headers,
      followRedirects: response.requestOptions.followRedirects,
      extra: response.requestOptions.extra,
      contentType: response.requestOptions.contentType,
      validateStatus: response.requestOptions.validateStatus,
    );

    FormData formData = FormData();
    if (response.requestOptions.data is FormData) {
      formData.fields.addAll(response.requestOptions.data.fields);
      for (MapEntry mapFile in response.requestOptions.data.files) {
        formData.files.add(
          MapEntry(
            mapFile.key,
            MultipartFile.fromFileSync(
              mapFile.value.FILE_PATH,
              filename: mapFile.value.filename,
            ),
          ),
        );
        response.requestOptions.data = formData;
      }
    }

    // print("cloneReq Before ${formData.fields}");
    final cloneReq = await Dio().request(
      response.requestOptions.path,
      options: opts,
      data: formData,
      queryParameters: response.requestOptions.queryParameters,
    );
    return handler.resolve(cloneReq);
    // } else {
    // if (resData.statusCode == 203) {
    //   await Datas().removeData();
    //   SystemNavigator.pop();
    // } else {
    //   return handler.next(response);
    // }
  }

  Future<void> userLogout(
      Response response, ResponseInterceptorHandler handler) async {
    // await Datas().removeData();
    // await Config().unsubscribeTopic();
    return handler.next(response);
  }

  Future<void> retryHit(Response<dynamic> response) async {}
}
