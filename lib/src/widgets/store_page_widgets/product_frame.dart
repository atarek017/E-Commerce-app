import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soaqtwo/src/core/models/faild_request.dart';
import 'package:soaqtwo/src/core/models/product.dart';
import 'package:soaqtwo/src/core/providers/product_provider.dart';
import 'package:soaqtwo/src/core/providers/user_provider.dart';
import 'package:soaqtwo/src/widgets/auth_widgets/dialog.dart';

class ProductFrame extends StatefulWidget {
  Product product;

  ProductFrame(this.product);

  @override
  _ProductFrameState createState() => _ProductFrameState();
}

class _ProductFrameState extends State<ProductFrame> {
  ProductProvider _productProvider;
  UserProvider _userProvider;
  Icon _favIcon = Icon(
    Icons.favorite_border,
    color: Colors.green,
  );
  bool _isFave = false;

  @override
  Widget build(BuildContext context) {
    _productProvider = Provider.of<ProductProvider>(context);
    _userProvider = Provider.of<UserProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 5),
                  blurRadius: 15,
                ),
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 35,
                    height: 15,
                    child: Center(
                      child: Text(
                        "1KG",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              Image.network(
                widget.product.photo,
                height: 70,
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                    icon: _favIcon,
                    onPressed: () {
                      _setFavourite();
                    }),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          widget.product.name,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          widget.product.price.toString(),
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  _setFavourite() async {
    if (_isFave == true) {
      _favIcon = Icon(
        Icons.favorite_border,
        color: Colors.green,
      );

      _isFave = false;
    } else {
      _favIcon = Icon(
        Icons.favorite,
        color: Colors.green,
      );

      var res = await _productProvider.setFavourite(
          _userProvider.user.id, widget.product.id);

      if (res == FailedRequest) {
        _isFave = false;
      }else{
        _isFave = true;

      }

    }

    setState(() {});
  }
}
