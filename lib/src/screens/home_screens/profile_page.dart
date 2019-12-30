import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:soaqtwo/src/core/providers/user_provider.dart';
import 'package:soaqtwo/src/widgets/profile_widgets/item_list.dart';
import 'package:soaqtwo/src/widgets/profile_widgets/profile_card.dart';

import '../authentication.dart';
import '../set_address.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<ProfilePage> {
  UserProvider _userProvider;
  String addressText = "";

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    setAddressText();

    return Scaffold(
      appBar: _buildAppBar(),
      body: ListView(
        children: <Widget>[
          ProfileCard(),
          SizedBox(
            height: 5,
          ),
          ProfileItemList(Icons.payment, "Payment", () {}),
          ProfileItemList(Icons.phone, _userProvider.user.phone, () {}),
          ProfileItemList(Icons.location_on, addressText, () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SetAddress()));
          }),
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text(
              "Logout",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authentication()));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      brightness: Brightness.dark,
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Text(
        'Keells',
        style: TextStyle(color: Colors.black),
      ),
      actions: <Widget>[
        Icon(Icons.mode_edit, color: Colors.black),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

//  setAddressText() async {
//    if (_userProvider.user.address != "" || _userProvider.user != null) {
//      List<String> locations = _userProvider.user.address.split(",");
//      double lat = double.parse(locations[0]);
//      double long = double.parse(locations[1]);
//      final coordinates = new Coordinates(lat, long);
//      await Geocoder.local
//          .findAddressesFromCoordinates(coordinates)
//          .catchError((onError) {
//        setState(() {
//          addressText = "Address not valide";
//        });
//      }).then((onValue) {
//        var first = onValue.first;
//        setState(() {
//          addressText = first.addressLine;
//        });
//      });
//    } else {
//      setState(() {
//        addressText = "Add Address ";
//      });
//    }
//  }

  setAddressText() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    if (_userProvider.user.address != "" || _userProvider.user != null) {
      List<String> locations = _userProvider.user.address.split(",");
      double lat = double.parse(locations[0]);
      double long = double.parse(locations[1]);
      try {
        List<Placemark> p =
            await geolocator.placemarkFromCoordinates(lat, long);
        Placemark place = p[0];
        setState(() {
          addressText =
              "${place.locality}, ${place.country}";
        });
      } catch (e) {
        print(e);

        setState(() {
          addressText = "Address not valide";
        });
      }
    } else {
      setState(() {
        addressText = "Add Address ";
      });
    }
  }
}
