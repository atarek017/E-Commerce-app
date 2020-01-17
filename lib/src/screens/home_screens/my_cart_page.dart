import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soaqtwo/src/core/models/cardProduct.dart';
import 'package:soaqtwo/src/core/providers/product_provider.dart';

class MyCartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyCartPage();
  }
}

class _MyCartPage extends State<MyCartPage> {
  ProductProvider _productProvider;
double height;
  @override
  Widget build(BuildContext context) {
    _productProvider = Provider.of<ProductProvider>(context);
    height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: height*.65,
            child: ListView.builder(
              itemCount: _productProvider.cardProducts.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {

                return Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: _productFrame(_productProvider.cardProducts[index]),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: subTotal(),
          )
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      brightness: Brightness.dark,
      elevation: 0,
      backgroundColor: Colors.green,
      automaticallyImplyLeading: false,
      title: Text(
        'Keells',
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        Icon(Icons.local_grocery_store, color: Colors.white),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Widget _productFrame(CardProduct product) {
    return Container(
      height: 100,
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
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
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.network(
                product.photo,
                height: 80,
                width: 80,
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  product.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "Unit Price : RS " +
                      (product.price * product.quantity).toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                quantityCounter(product.quantity)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget quantityCounter(int quant) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
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
              if (quant == 1) {
                quant = 1;
              } else {
                quant--;
              }
            });
          },
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          '$quant',
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
              borderRadius: BorderRadius.circular(5),
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
              quant++;

              print("quant :: $quant");
            });
          },
        ),
      ],
    );
  }

  Widget subTotal() {
    return Container(
      height: height*.1,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 5),
              blurRadius: 30,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "SubTotal(" +
                  _productProvider.cardProducts.length.toString() +
                  " Items)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Rs ${getTotalPrice()}" ,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  double getTotalPrice() {
    double totalPrice = 0;
    for (int i = 0; i <_productProvider.cardProducts.length; i++){
      totalPrice += (_productProvider.cardProducts[i].price * _productProvider.cardProducts[i].quantity);
    }

    return totalPrice;
  }
}
