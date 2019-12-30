import 'package:flutter/foundation.dart';

class FailedRequest {
  String message;
  int code;
  bool status;

  FailedRequest({
    @required this.message,
    @required this.code,
    @required this.status,
  });
}
