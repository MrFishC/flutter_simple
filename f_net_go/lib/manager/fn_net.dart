
import '../base/base_request.dart';
import '../net/dio_adapter.dart';
import '../base/fn_adapter.dart';
import '../exception/fn_error.dart';

class FnNet{
  FnNet._();

  static FnNet? _instance;

  static FnNet getInstance() {
    if (_instance == null) {
      _instance = FnNet._();
    }
    return _instance!;
  }

  FnErrorInterceptor? _fnErrorInterceptor;

  Future fire(FnBaseRequest request) async {
    FnResponse? response;
    var error;
    try {
      response = await send(request);
    } on FnError catch (e) {
      error = e;
      response = e.data;
      printLog(e.message);
    } catch (e) {
      //其它异常
      error = e;
      printLog(e);
    }
    if (response == null) {
      printLog(error);
    }
    var result = response?.data;
    printLog(result);
    var status = response?.statusCode;
    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), data: result);
      default:
        throw FnError(status ?? -1, result.toString(), data: result);
    }
  }

  Future<FnResponse<T>> send<T>(FnBaseRequest request) async {
    ///使用Dio发送请求
    FnAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void printLog(log) {
    print('fn_net:' + log.toString());
  }

  void setErrorInterceptor(FnErrorInterceptor interceptor) {
    this._fnErrorInterceptor = interceptor;
  }
}