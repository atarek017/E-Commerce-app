import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soaqtwo/src/core/providers/product_provider.dart';

class SelectedProductPage extends StatefulWidget {
  String title;

  SelectedProductPage(this.title);

  @override
  State<StatefulWidget> createState() {
    return _SelectedProductPageState();
  }
}

class _SelectedProductPageState extends State<SelectedProductPage> {
//  ProductProvider _productProvider;

  Icon _favIcon;
  double height;
  double width;
  int _counter = 1;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery
        .of(context)
        .size
        .height;
    width = MediaQuery
        .of(context)
        .size
        .width;

//    _productProvider = Provider.of<ProductProvider>(context);
    _favIcon = Icon(
      Icons.favorite_border,
      color: Colors.green,
    );

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
            "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS3TPKVJU0dedNjsxtaOeR9F7gY-ucPCJM311c5wdasQJO2swFe",
            height: 70,
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
                icon: _favIcon,
                onPressed: () {
//                  _setFavourite();
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
            "DDFSsds",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Rs. 1,100.0",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
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
          quantityCounter()
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
              _counter--;
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
}
