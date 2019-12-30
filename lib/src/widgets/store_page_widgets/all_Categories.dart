import 'package:flutter/material.dart';
import 'package:soaqtwo/src/core/models/product_type.dart';
import 'package:soaqtwo/src/widgets/store_page_widgets/product_type_widget.dart';

class AllCategoriesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var listItems = addProductItems();

    return Container(
      height: 150,
      child: ListView.builder(
        itemCount: listItems.length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ProductTypeItem(listItems[index]);
        },
      ),
    );
  }

  List<ProductType> addProductItems() {
    var list = List<ProductType>();
    var data1 = ProductType('House Hold', "https://cdn2.iconfinder.com/data/icons/property-insurance/256/Landlord_Insurance-512.png");
    list.add(data1);
    var data2 = ProductType('Grocery', "https://cdn1.iconfinder.com/data/icons/smashicons-gastronomy-outline-vol-3/57/140_-_Grocery_Bag_gastronomy_food_cooking-512.png");
    list.add(data2);
      var data3 = ProductType('Liquor', "https://cdn1.iconfinder.com/data/icons/drugs-6/100/45-512.png");
    list.add(data3);
    var data4 = ProductType('Breads', "https://image.flaticon.com/icons/png/512/108/108019.png");
    list.add(data4);
    return list;
  }
}
