import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soaqtwo/src/core/models/faild_request.dart';
import 'package:soaqtwo/src/core/providers/product_provider.dart';
import 'package:soaqtwo/src/core/providers/user_provider.dart';
import 'package:soaqtwo/src/screens/home_screens/homePage.dart';
import 'package:soaqtwo/src/widgets/auth_widgets/texField_widget.dart';
import 'dialog.dart';
import 'auth_button.dart';

class SignInWidget extends StatefulWidget {
  BuildContext _context;

  SignInWidget(this._context);

  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _pawwordController = TextEditingController();

  UserProvider _userProvider;
  ProductProvider _productProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    _productProvider = Provider.of<ProductProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: <Widget>[
            TexFieldWidget(
                "Email", _emailController, TextInputType.emailAddress),
            SizedBox(
              height: 10,
            ),
            TexFieldWidget("Password", _pawwordController, TextInputType.text),
            AuthButton(() {
              _signIn();
            })
          ],
        ),
      ),
    );
  }

  _signIn() async {
    var res = await _userProvider.login(
        _emailController.text, _pawwordController.text);

    if (res is FailedRequest) {
      Dialogs.showErrorDialog(widget._context,
          message: res.message, code: res.code);
      print('results ${res.toString()}');
    } else {
      print("Sing in success");

      await _productProvider.nexusDeals();
      await _productProvider.keellsDeals();
      print("&&&&&&&&&&&**********************************&&&&&&&&&&&&&&&&&&________________________________");
      await _productProvider.getFavouriteProducts(_userProvider.user.id);

      Navigator.pushReplacement(
          widget._context, MaterialPageRoute(builder: (context) => HomePage()));
    }

    _userProvider.isLoading = false;
  }
}
