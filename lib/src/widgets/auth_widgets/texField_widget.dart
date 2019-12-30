import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TexFieldWidget extends StatelessWidget {
  String text;
  TextEditingController controller;
  TextInputType inputType;

  TexFieldWidget(
    this.text,
    this.controller,
    this.inputType,
  );

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(fontSize: 18),
      keyboardType: inputType,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        hintText: text,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey)),
      ),
    );
  }
}
