import '../base/base_request.dart';
import '../base/fn_adapter.dart';

///测试适配器，mock数据
class MockAdapter extends FnAdapter {
  @override
  Future<FnResponse<T>> send<T>(FnBaseRequest request) async {
    return Future.delayed(Duration(milliseconds: 1000), () {
      return FnResponse(
          request: request,
          data: {"code": 0, "message": 'success', "data": "data"} as T,
          statusCode: 200);
    });
  }
}
