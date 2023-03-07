
import 'dart:convert';
import 'base_request.dart';

abstract class FnAdapter{
  Future<FnResponse<T>> send<T>(FnBaseRequest request);
}

//根据后台提供的格式进行更改
class FnResponse<T> {
  FnResponse({
    this.data,
    required this.request,
    this.statusCode,
    this.statusMessage,
    this.extra,
  });

  /// 相应body中内容
  T? data;

  /// 请求信息
  FnBaseRequest request;

  /// code
  int? statusCode;

  //相应消息
  String? statusMessage;

  /// 扩展字段
  late dynamic extra;

  /// 格式化数据
  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}