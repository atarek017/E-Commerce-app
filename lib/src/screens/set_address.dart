import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:soaqtwo/src/core/models/faild_request.dart';
import 'package:soaqtwo/src/core/providers/user_provider.dart';
import 'package:soaqtwo/src/widgets/auth_widgets/dialog.dart';


class SetAddress extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddressState();
  }
}

class _AddressState extends State<SetAddress> {
  static LatLng _initialPosition = LatLng(30.4629229, 31.1884205);
  LatLng _location;
  GoogleMapController mapController;
  UserProvider _userProvider;

  void onCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _getUserLocation();
    });
  }

  void getAddress() async {
    _userProvider.user.address =
        _location.latitude.toString() + "," + _location.longitude.toString();
    var res = await _userProvider.updateUser(_userProvider.user);

    if (res is FailedRequest) {
      Dialogs.showErrorDialog(context, message: res.message, code: res.code);
      print('results ${res.toString()}');
    } else {
      Navigator.pop(context);
    }

  }

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);

    double hight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 13,
            ),
            onMapCreated: onCreated,
            myLocationEnabled: true,
            mapType: MapType.normal,
            onCameraMove: _onCameraMove,
            compassEnabled: true,
          ),
          Positioned(
            top: hight * .45,
            left: width * .45,
            child: IconButton(
                icon: Icon(
                  Icons.add_location,
                  color: Colors.blue,
                  size: 40,
                ),
                onPressed: () {
                  getAddress();
                }),
          ),
        ],
      ),
    );
  }

  Future<void> _getUserLocation() async {
    Position position;
    try {
      position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    } on PlatformException {
      position = null;
    }

    if (!mounted) {
      return;
    }
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      try {
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: _initialPosition, zoom: 16.0),
          ),
        );
      } catch (error) {
        print("eror" + error.toString());
      }
    });
  }

  _onCameraMove(CameraPosition cameraPosition) {
    setState(() {
      _location = cameraPosition.target;
    });
  }
}
