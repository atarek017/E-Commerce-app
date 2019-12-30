import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soaqtwo/src/core/providers/user_provider.dart';
import 'package:soaqtwo/src/widgets/auth_widgets/signIn_widget.dart';
import 'package:soaqtwo/src/widgets/auth_widgets/signUp_widget.dart';


class Authentication extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthenticationState();
  }
}

class _AuthenticationState extends State<Authentication> {
  Color signUpdColor;
  Color signIndColor;
  bool switchAuth = true;
  UserProvider _userProvider;

  @override
  void initState() {
    setSignIn();
    super.initState();
  }

  void setSignUp() {
    setState(() {
      signUpdColor = Colors.green;
      signIndColor = Colors.grey;
      switchAuth = true;
    });
  }

  void setSignIn() {
    setState(() {
      signUpdColor = Colors.grey;
      signIndColor = Colors.green;
      switchAuth = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);

    double hight = MediaQuery.of(context).size.height;
    return Scaffold(

      body: _userProvider.isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: switchAuth == true ? hight * .95 : hight * .7,
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
                    bottomRight: Radius.circular(32)),
              ),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 20,
                              color: signIndColor,
                            ),
                          ),
                          onTap: setSignIn,
                        ),
                        InkWell(
                          onTap: setSignUp,
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 20,
                              color: signUpdColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, top: 8),
                    child: Text(
                      'Welcome to keells.',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, top: 8),
                    child: Text(
                      'Let\'s get started',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  switchAuth == true ? SignUpWidget(context) : SignInWidget(context),
                ],
              ),
            ),
    );
  }
}
