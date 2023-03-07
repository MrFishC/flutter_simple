import 'package:dio/dio.dart';

import '../base/base_request.dart';
import '../base/fn_adapter.dart';
import '../exception/fn_error.dart';

class DioAdapter extends FnAdapter {

  @override
  Future<FnResponse<T>> send<T>(FnBaseRequest request) async{
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

  ///构建FnResponse
  Future<FnResponse<T>> buildRes<T>(
      Response? response, FnBaseRequest request) {
    //Future（异步任务的封装） 类似于js的promise   Future.value 是Future的静态方法
    return Future.value(FnResponse(
      //?.防止response为空
        data: response?.data,
        request: request,
        statusCode: response?.statusCode,
        statusMessage: response?.statusMessage,
        extra: response));
  }

}