import 'package:flutter/material.dart';
import 'package:soaqtwo/src/core/models/product_type.dart';

class ProductTypeItem extends StatelessWidget {
  ProductType data;

  ProductTypeItem(this.data);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        margin: EdgeInsets.all(10),
        width: 95,
        height: 95,
        alignment: Alignment.center,
        child: Center(
          child: Image.network(
            data.image,
            color: Colors.black38,
            height: 50,
            width: 50,
          ),
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 5),
              blurRadius: 15,
            )
          ],
        ),
      ),
      Row(
        children: <Widget>[
          Text(data.name),
          Icon(
            Icons.keyboard_arrow_right,
            size: 14,
          )
        ],
      )
    ]);
  }
}
