import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soaqtwo/src/core/providers/product_provider.dart';
import 'package:soaqtwo/src/screens/selected_product_page.dart';
import 'package:soaqtwo/src/widgets/store_page_widgets/product_frame.dart';

class NexusDeals extends StatelessWidget {
  ProductProvider _productProvider;

  @override
  Widget build(BuildContext context) {
    _productProvider = Provider.of<ProductProvider>(context);
    return Container(
      height: 200,
      child: ListView.builder(
        itemCount: _productProvider.nexusProducts.length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: ProductFrame(_productProvider.nexusProducts[index]),
            ),
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
}
