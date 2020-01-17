import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:provider/provider.dart';
import 'package:soaqtwo/src/core/providers/user_provider.dart';

class AddUserImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddUserImageState();
  }
}

class _AddUserImageState extends State<AddUserImage> {
  File _image;
  UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker'),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: _image == null
                ? Text('No image selected.')
                : Image.file(_image),
          ),
          _image != null
              ? Positioned(
                  bottom: 20,
                  left: 20,
                  child: IconButton(
                      color: Colors.blue,
                      highlightColor: Colors.blue,
                      disabledColor: Colors.blue,
                      icon: Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        _cropImage();
                      }),
                )
              : Container(),
          _image != null
              ? Positioned(
                  bottom: 20,
                  left: 80,
                  child: IconButton(
                      icon: Icon(Icons.file_upload, color: Colors.blue),
                      onPressed: () async {
                        await _userProvider.uploadImage(_image);
                        Navigator.pop(context);
                      }),
                )
              : Container(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _image.path,
        androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            toolbarTitle: 'Crop It'));

    setState(() {
      _image = cropped ?? _image;
    });
  }
}
