import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soaqtwo/src/widgets/store_page_widgets/all_Categories.dart';
import 'package:soaqtwo/src/widgets/store_page_widgets/keells_deals.dart';
import 'package:soaqtwo/src/widgets/store_page_widgets/nexus_deals.dart';

class Store extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StoreState();
  }
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        color: const Color(0xffF4F7FA),
        child: ListView(
          children: <Widget>[
            _allCatTitle('All Categories', () {}),
            AllCategoriesWidget(),
            _allCatTitle('Nexus Member Deals', () {}),
            NexusDeals(),
            _allCatTitle('Keells Deals', () {}),
            KeellsDeals(),
          ],
        ),
      ),
    );
  }

  Widget _allCatTitle(String text, Function function) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 16, top: 4),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        InkWell(
          onTap: function,
          child: Padding(
            padding: EdgeInsets.only(left: 16, top: 4),
            child: FlatButton(
              onPressed: () {},
              child: Text(
                'View All',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ),
        ),
      ],
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
        Icon(Icons.search, color: Colors.white),
        SizedBox(
          width: 10,
        ),
        Icon(Icons.notifications_none, color: Colors.white),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
