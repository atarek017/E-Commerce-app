import 'package:flutter/cupertino.dart';

class MyCartPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyCartPage();
  }

}

class _MyCartPage extends State<MyCartPage>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("My cart"),
    );
  }

}