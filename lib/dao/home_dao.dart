import 'package:f_net_go/base/base_request.dart';
import 'package:f_net_go/manager/fn_net.dart';
import '../model/home_model.dart';
import '../request/home_request.dart';

class HomeDao {
  static const AUTHORIZATION = "authorization";
  static const LOGIN = 0;
  static const REGISTER = 1;

  static loadHomeRecommend(int tid,
      {int pageIndex = 1, int pageSize = 1}) async {
    print("当前TID:$tid");
    FnBaseRequest request = HomeVideoRequest();
    request
        .add("tid", tid)
        .add("pageIndex", pageIndex)
        .add("pageSize", pageSize);
    var result = await FnNet.getInstance().fire(request);
    return ResponseData.fromJson(result).list;
  }
}
