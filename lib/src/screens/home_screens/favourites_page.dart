import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soaqtwo/src/core/models/product.dart';
import 'package:soaqtwo/src/core/providers/product_provider.dart';
import '../selected_product_page.dart';

class FavouritesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavouritesPageState();
  }
}

class _FavouritesPageState extends State<FavouritesPage> {
  ProductProvider _productProvider;

  @override
  Widget build(BuildContext context) {
    _productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: _buildAppBar(),
      body: GridView.builder(
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        physics: BouncingScrollPhysics(),
        itemCount: _productProvider.favouriteProducts.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: _productForm(_productProvider.favouriteProducts[index]),
            onTap: () {
              _productProvider.selectedProduct =
                  _productProvider.nexusProducts[index];
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SelectedProductPage("Nexus Deal")));
            },
          );
        },
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
        Icon(Icons.favorite, color: Colors.white),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Widget _productForm(Product product) {
    return Container(
      margin: const EdgeInsets.all(10),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(
            product.photo,
            height: 80,
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            product.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
