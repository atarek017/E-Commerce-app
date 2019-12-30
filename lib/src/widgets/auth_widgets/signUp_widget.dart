import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soaqtwo/src/core/models/faild_request.dart';
import 'package:soaqtwo/src/core/models/user.dart';
import 'package:soaqtwo/src/core/providers/user_provider.dart';
import 'package:soaqtwo/src/screens/verify_page.dart';
import 'package:soaqtwo/src/widgets/auth_widgets/texField_widget.dart';

import 'auth_button.dart';
import 'dialog.dart';

class SignUpWidget extends StatefulWidget {
  BuildContext _context;

  SignUpWidget(this._context);

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pawwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: <Widget>[
            TexFieldWidget("Name", _nameController, TextInputType.text),
            SizedBox(
              height: 10,
            ),
            TexFieldWidget(
                "Email", _emailController, TextInputType.emailAddress),
            SizedBox(
              height: 10,
            ),
            TexFieldWidget("Password", _pawwordController, TextInputType.text),
            SizedBox(
              height: 10,
            ),
            TexFieldWidget("Phone", _phoneController, TextInputType.phone),
            AuthButton(() {
              _signUp();
            })
          ],
        ),
      ),
    );
  }

  _signUp() async {
    User _user = User(
      name: _nameController.text,
      email: _emailController.text,
      password: _pawwordController.text,
      phone: _phoneController.text,
    );

    var res = await _userProvider.signUp(_user);

    if (res is FailedRequest) {
      Dialogs.showErrorDialog(widget._context, message: res.message, code: res.code);
      print('results ${res.toString()}');
    } else {
      print(" sign up success");

      Navigator.push(widget._context,
          MaterialPageRoute(builder: (context) => VerifyPage()));
    }
  }
}
