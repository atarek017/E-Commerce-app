import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileItemList extends StatefulWidget {
  IconData _icon;
  Function _function;
  String _text;

  ProfileItemList(this._icon, this._text, this._function);

  @override
  State<StatefulWidget> createState() {
    return _ProfileItemListState();
  }
}

class _ProfileItemListState extends State<ProfileItemList> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(widget._icon),
      trailing: IconButton(
          icon: Icon(Icons.arrow_forward_ios), onPressed: widget._function),
      title: Text(
        widget._text,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
    ;
  }
}
