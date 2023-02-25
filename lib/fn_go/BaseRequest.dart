enum HttpMethod { GET, POST, DELETE }

abstract class BaseRequest {
  var useHttps = true;

  //域名
  String authority() {
    return "api.bilibili.com";
  }

  //地址
  String path();

  //参数1
  var pathParams;

  //参数2
  Map<String, String> params = Map();

  //请求方法
  HttpMethod httpMethod();

  //是否登录
  bool needLogin();

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
    //http和https切换
    if (useHttps) {
      /**
       * 域名，路径，参数
       */
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    print('fn_go url:${uri.toString()}');
    return uri.toString();
  }

  ///添加参数
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  Map<String, dynamic> header = {};

  /// 添加header
  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}
