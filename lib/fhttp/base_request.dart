
import 'package:f_net_go/base/base_request.dart';
import 'package:f_net_go/cache/fc_cache.dart';

abstract class BaseRequest extends FnBaseRequest{
  @override
  String authority() {
    return "api.bilibili.cn";
  }

  @override
  String authorization() {
    return "authorization";
  }

  @override
  String getToken() {
    return FcCache.getInstance().get(authorization());
  }

}
