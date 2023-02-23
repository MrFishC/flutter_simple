enum HttpMethod { GET, POST, DELETE }

abstract class BaseRequest {
  var pathParams;
  Map<String, String> params = Map();

  var useHttps = true;

}