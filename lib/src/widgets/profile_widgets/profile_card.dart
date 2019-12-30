import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soaqtwo/src/core/providers/user_provider.dart';
import 'package:soaqtwo/src/screens/add_user_image.dart';

class ProfileCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileCardState();
  }
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    UserProvider _userProvider = Provider.of<UserProvider>(context);

    return Container(
      height: 200,
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
            bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 2, color: Colors.white),
                  bottom: BorderSide(width: 2, color: Colors.white),
                  right: BorderSide(width: 2, color: Colors.white),
                  left: BorderSide(width: 2, color: Colors.white),
                ),
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black26,
                    offset: new Offset(0.0, -1.0),
                    blurRadius: 15.0,
                  )
                ],
                borderRadius: BorderRadius.circular(45),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: _userProvider.user.photo == ""
                      ? NetworkImage(
                          "https://images.pexels.com/photos/281260/pexels-photo-281260.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940")
                      : NetworkImage(_userProvider.user.photo),
                ),
                color: Colors.blue),
            child: _userProvider.user.photo == ""
                ? Center(
                    child: IconButton(
                      icon: Icon(
                        Icons.add_a_photo,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddUserImage()));
                      },
                    ),
                  )
                : Container(),
          ),
          Text(
            _userProvider.user.name,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            _userProvider.user.email,
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          Text(
            _userProvider.user.phone,
            style: TextStyle(color: Colors.grey, fontSize: 11),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
