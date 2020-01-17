import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code_input/flutter_verification_code_input.dart';
import 'package:provider/provider.dart';
import 'package:soaqtwo/src/core/models/faild_request.dart';
import 'package:soaqtwo/src/core/providers/product_provider.dart';
import 'package:soaqtwo/src/core/providers/user_provider.dart';
import 'package:soaqtwo/src/widgets/auth_widgets/dialog.dart';

import 'home_screens/homePage.dart';

class VerifyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VerifyPageState();
  }
}

class _VerifyPageState extends State<VerifyPage> {
  UserProvider _userProvider;

  bool verify = false;
  String code;
  ProductProvider _productProvider;
  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    _productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          title: Text('Verify', style: TextStyle(color: Colors.black)),
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Container(
          height: 250,
          decoration: BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  color: Colors.black26,
                  offset: new Offset(0.0, 2.0),
                  blurRadius: 25.0,
                )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  'Verify your number',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, top: 8),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: '4 digit code sent to ',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      TextSpan(
                        text: _userProvider.user.phone,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: _inputFields(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 0),
                      child: resendButton()),
                  Align(
                    alignment: Alignment.centerRight,
                    child: submitButton(),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget _inputFields() {
    return VerificationCodeInput(
      keyboardType: TextInputType.number,
      itemDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(8)),
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
      ),
      length: 4,
      itemSize: 50,
      onCompleted: (String value) {
        setState(() {
          verify = true;
          code = value;
        });
      },
    );
  }

  Widget resendButton() {
    return OutlineButton(
      padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      textColor: Colors.red,
      color: Colors.red,
      borderSide: BorderSide(color: Colors.red),
      child: Text(
        'Resend',
        style: TextStyle(),
      ),
      onPressed: () async {
        var res = await _userProvider.resendCode(_userProvider.user);

        if (res is FailedRequest) {
          Dialogs.showErrorDialog(context,
              message: res.message, code: res.code);
          print('results ${res.toString()}');
        } else {
          print(" success code send ");

          Dialogs.showErrorDialog(context,
              message: "code send successfuly ", code: 200);
        }
      },
    );
  }

  Widget submitButton() {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: verify ? Colors.green : Colors.grey,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        color: Colors.white,
        onPressed: () async {
          var res = await _userProvider.verifyUser(_userProvider.user.id, code);

          if (res is FailedRequest) {
            Dialogs.showErrorDialog(context,
                message: res.message, code: res.code);
            print('results ${res.toString()}');
          } else {

            await _productProvider.nexusDeals();
            await _productProvider.keellsDeals();
            await _productProvider.getFavouriteProducts(_userProvider.user.id);

            await _productProvider.getCardProducts(_userProvider.user.id);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          }
        },
        icon: Icon(Icons.check),
      ),
    );
  }
}
