import 'package:f_net_go/base/base_request.dart';
import 'package:flutter_simple/fhttp/base_request.dart';

//首页推荐视频
class HomeVideoRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return "recommend";
  }
}
