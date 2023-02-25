import 'package:dio/dio.dart';

import 'base_request.dart';
import 'fn_adapter.dart';
import 'fn_error.dart';

class DioAdapter extends FnAdapter {

  @override
  Future<FnResponse<T>> send<T>(BaseRequest request) async{
    var response,options = Options(headers:request.header);
    var error;
    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await Dio().get(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await Dio()
            .post(request.url(), data: request.params, options: options);
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await Dio()
            .delete(request.url(), data: request.params, options: options);
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }
    if (error != null) {
      ///抛出FwNetError
      throw FnError(response?.statusCode ?? -1, error.toString(),
          data: await buildRes(response, request));
    }
    return buildRes(response, request);
  }

// todo  重学 Future

  ///构建FnResponse
  Future<FnResponse<T>> buildRes<T>(
      Response? response, BaseRequest request) {
    return Future.value(FnResponse(
      //?.防止response为空
        data: response?.data,
        request: request,
        statusCode: response?.statusCode,
        statusMessage: response?.statusMessage,
        extra: response));
  }

}