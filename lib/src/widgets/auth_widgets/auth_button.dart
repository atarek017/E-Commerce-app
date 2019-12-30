import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  Function function;

  AuthButton(this.function);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
        child: IconButton(
          color: Colors.white,
          onPressed: function,
          icon: Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
