import '../cache/fc_cache.dart';

enum HttpMethod { GET, POST, DELETE }

abstract class FnBaseRequest {
  String authority();

  String authorization();

  String getToken();

  //参数1
  var pathParams;

  //参数2
  Map<String, String> params = Map();

  //请求头
  Map<String, dynamic> header = {};

  //地址
  String path();

  //请求方法
  HttpMethod httpMethod();

  //是否登录
  bool needLogin();

  //是否是HTTPS
  bool useHttps = false;

  //添加参数
  FnBaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  // 添加header
  FnBaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }


  String url() {
    Uri uri;

    var pathStr = path();
    //拼接path参数
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }

    var param;
    if (params.isNotEmpty && httpMethod() == HttpMethod.GET) {
      param = params;
    }

    //http和https切换
    if (useHttps) {
      /**
       * 域名，路径，参数
       */
      uri = Uri.https(authority(), pathStr, param);
    } else {
      uri = Uri.http(authority(), pathStr, param);
    }

    if (needLogin()) {
      // String auth = FcCache.getInstance().get(authorization());
      addHeader(authorization(), getToken());
    }

    return uri.toString();
  }

// var useHttps = true;
//
// //域名
// String authority() {
//   return "api.bilibili.com";
// }
//
// //地址
// String path();
//
// //参数1
// var pathParams;
//
// //参数2
// Map<String, String> params = Map();
//
// //请求方法
// HttpMethod httpMethod();
//
// //是否登录
// bool needLogin();
//
// String url() {
//   Uri uri;
//   var pathStr = path();
//   //拼接path参数
//   if (pathParams != null) {
//     if (path().endsWith("/")) {
//       pathStr = "${path()}$pathParams";
//     } else {
//       pathStr = "${path()}/$pathParams";
//     }
//   }
//   //http和https切换
//   if (useHttps) {
//     /**
//      * 域名，路径，参数
//      */
//     uri = Uri.https(authority(), pathStr, params);
//   } else {
//     uri = Uri.http(authority(), pathStr, params);
//   }
//   print('fn_go url:${uri.toString()}');
//
//   if (needLogin()) {
//     String auth = FcCache.getInstance().get(authorization());
//     addHeader(authorization(), auth);
//   }
//
//   return uri.toString();
// }
//
// ///添加参数
// BaseRequest add(String k, Object v) {
//   params[k] = v.toString();
//   return this;
// }
//
// Map<String, dynamic> header = {};
//
// /// 添加header
// BaseRequest addHeader(String k, Object v) {
//   header[k] = v.toString();
//   return this;
// }
//
// //鉴权
// String authorization() {
//   return "authorization";
// }
//
// String getToken() {
//   return FcCache.getInstance().get(authorization());
// }
}
