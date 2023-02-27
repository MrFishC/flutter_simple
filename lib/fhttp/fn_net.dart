
import 'base_request.dart';
import 'dio_adapter.dart';
import 'fn_adapter.dart';
import 'fn_error.dart';

class FnNet{
  FnNet._();

  static FnNet? _instance;

  static FnNet getInstance() {
    if (_instance == null) {
      _instance = FnNet._();
    }
    return _instance!;
  }

  Future fire(BaseRequest request) async {
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

  Future<FnResponse<T>> send<T>(BaseRequest request) async {
    ///使用Dio发送请求
    FnAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void printLog(log) {
    print('fn_net:' + log.toString());
  }
}