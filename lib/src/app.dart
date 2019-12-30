import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soaqtwo/src/screens/authentication.dart';
import 'package:soaqtwo/src/screens/home_screens/homePage.dart';
import 'package:soaqtwo/src/screens/set_address.dart';

import 'core/providers/product_provider.dart';
import 'core/providers/user_provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProvider()),
        ChangeNotifierProvider.value(value: ProductProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Authentication(),
      ),
    );
  }
}
