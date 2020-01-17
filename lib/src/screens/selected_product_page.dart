import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soaqtwo/src/core/models/cardProductItem.dart';
import 'package:soaqtwo/src/core/models/faild_request.dart';
import 'package:soaqtwo/src/core/providers/product_provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:soaqtwo/src/core/providers/user_provider.dart';
import 'package:soaqtwo/src/widgets/auth_widgets/dialog.dart';

class SelectedProductPage extends StatefulWidget {
  String title;

  SelectedProductPage(this.title);

  @override
  State<StatefulWidget> createState() {
    return _SelectedProductPageState();
  }
}

class _SelectedProductPageState extends State<SelectedProductPage> {
  ProductProvider _productProvider;
  UserProvider _userProvider;

  Icon _favIcon = Icon(
    Icons.favorite_border,
    color: Colors.green,
  );
  bool _isFave = false;

  double height;
  double width;
  int _counter = 1;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    _productProvider = Provider.of<ProductProvider>(context);
    _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.black, size: 15),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: height * .15,
            left: width * .05,
            child: productDetails(),
          ),
          Positioned(
            left: width * .23,
            child: productFram(),
          ),
        ],
      ),
    );
  }

  Widget productFram() {
    return Container(
      width: 200,
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
            _productProvider.selectedProduct.photo,
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
    );
  }

  Widget productDetails() {
    return Container(
      width: width * .90,
      height: height * .65,
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
        children: <Widget>[
          SizedBox(
            height: height * .15,
          ),
          Text(
            _productProvider.selectedProduct.name,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Rs. " + _productProvider.selectedProduct.price.toString(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          ratingBar(),
          SizedBox(
            height: 30,
          ),
          Text(
            "Quantity",
            style: TextStyle(fontSize: 13),
          ),
          SizedBox(
            height: 5,
          ),
          quantityCounter(),
          SizedBox(
            height: 30,
          ),
          buyNow(),
          SizedBox(
            height: 10,
          ),
          addToCard()
        ],
      ),
    );
  }

  Widget quantityCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(
                color: Colors.black,
                style: BorderStyle.solid,
              ),
            ),
            child: Center(
              child: Text(
                "-",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          onTap: () {
            setState(() {
              if (_counter == 1) {
                _counter = 1;
              } else {
                _counter--;
              }
            });
          },
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          '$_counter',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(
          width: 10,
        ),
        InkWell(
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(
                color: Colors.black,
                style: BorderStyle.solid,
              ),
            ),
            child: Center(
              child: Text(
                "+",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          onTap: () {
            setState(() {
              _counter++;
            });
          },
        ),
      ],
    );
  }

  Widget ratingBar() {
    return RatingBar(
      initialRating: double.parse(_productProvider.selectedProduct.rate),
      tapOnlyMode: false,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemSize: 25,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.deepOrange,
      ),
    );
  }

  Widget buyNow() {
    return GestureDetector(
      child: Container(
        width: width * .7,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.green, width: 2),
        ),
        child: Center(
          child: Text(
            "Buy Now",
            style: TextStyle(color: Colors.green, fontSize: 16),
          ),
        ),
      ),
      onTap: () {},
    );
  }

  Widget addToCard() {
    return GestureDetector(
      child: Container(
        width: width * .7,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            "Add To Card",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
      onTap: () async {
        var res = await _productProvider.addToCard(CardProductItem(
            quantity: _counter,
            productId: _productProvider.selectedProduct.id,
            userId: _userProvider.user.id));


        if (res is FailedRequest) {
          Dialogs.showErrorDialog(context,
              message: res.message, code: res.code);
          print('results ${res.toString()}');
        }else{
          await _productProvider.getCardProducts(_userProvider.user.id);

          Dialogs.showErrorDialog(context,
              message: "added sucessfuly", code: 200);
        }


      },
    );
  }

  _setFavourite() {
    setState(() {
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
        _isFave = true;
      }
    });
  }
}
