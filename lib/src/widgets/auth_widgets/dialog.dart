import 'package:flutter/material.dart';

class Dialogs {
  static showErrorDialog(BuildContext context,
      {@required String message, @required int code}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Ok'),
            )
          ],
          title: Text('error $code'),
          content: Text(message),
          backgroundColor: Colors.white,
        );
      },
    );
  }
}
