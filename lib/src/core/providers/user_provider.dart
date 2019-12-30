import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:soaqtwo/src/core/models/faild_request.dart';
import 'package:soaqtwo/src/core/models/user.dart';
import '../environment.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserProvider with ChangeNotifier {
  User _user;

  User get user => _user;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<dynamic> signUp(User user) async {
    final Map<String, dynamic> body = user.toJson();
    _isLoading = true;
    notifyListeners();
    print('Starting request');
    http.Response response = await http.post(Environment.userSignUp,
        body: json.encode(body), headers: Environment.requestHeader);
    print('Completed request');
    print('user login response : ${response.body}');
    Map<String, dynamic> res = json.decode(response.body);
    var results;
    if (res['code'] == 200) {
      // login successful
      _user = User.fromJson(res['data']);
      results = true;
    } else {
      // login failed;
      results =
          FailedRequest(code: 400, message: res['message'], status: false);
    }
    _isLoading = false;
    notifyListeners();
    return results;
  }

  Future<dynamic> login(String email, String password) async {
    final Map<String, dynamic> body = {'email': email, 'password': password};

    _isLoading = true;
    notifyListeners();
    print('Starting request');
    http.Response response = await http.post(Environment.userLogin,
        body: json.encode(body), headers: Environment.requestHeader);
    print('Completed request');
    print('user login response : ${response.body}');
    Map<String, dynamic> res = json.decode(response.body);
    var results;
    if (res['code'] == 200) {
      // login successful
      _user = User.fromJson(res['data']);
      results = true;
    } else {
      // login failed;
      results =
          FailedRequest(code: 400, message: res['message'], status: false);
    }
    _isLoading = false;
    notifyListeners();
    return results;
  }

  Future<dynamic> resendCode(User user) async {
    final Map<String, dynamic> body = user.toJson();
    _isLoading = true;
    notifyListeners();
    print('Starting request');
    http.Response response = await http.post(Environment.userResendVerifyCode,
        body: json.encode(body), headers: Environment.requestHeader);
    print('Completed request');
    print('user resend verify code response : ${response.body}');
    Map<String, dynamic> res = json.decode(response.body);
    var results;
    if (res['code'] == 200) {
      _user = User.fromJson(res['data']);
      results = true;
    } else {
      results =
          FailedRequest(code: 400, message: res['message'], status: false);
    }
    _isLoading = false;
    notifyListeners();
    return results;
  }

  Future<dynamic> verifyUser(String id, String code) async {
    final Map<String, dynamic> body = {'id': id, 'verify': code};
    _isLoading = true;
    notifyListeners();
    print('Starting request');
    http.Response response = await http.post(Environment.userVerify,
        body: json.encode(body), headers: Environment.requestHeader);
    print('Completed request');
    print('user verify response : ${response.body}');
    Map<String, dynamic> res = json.decode(response.body);
    var results;
    if (res['code'] == 200) {
      results = true;
    } else {
      results =
          FailedRequest(code: 400, message: res['message'], status: false);
    }
    _isLoading = false;
    notifyListeners();
    return results;
  }

  Future<dynamic> updateUser(User user) async {
    final Map<String, dynamic> body = user.toJson();
    _isLoading = true;
    notifyListeners();
    print('Starting request');
    print(body.toString());
    http.Response response = await http.post(Environment.userUpdateInfo,
        body: json.encode(body), headers: Environment.requestHeader);
    print('Completed request');
    print('user update response : ${response.body}');
    Map<String, dynamic> res = json.decode(response.body);
    var results;
    if (res['code'] == 200) {
      _user = User.fromJson(res['data']);
      results = true;
    } else {
      results =
          FailedRequest(code: 400, message: res['message'], status: false);
    }
    _isLoading = false;
    notifyListeners();
    return results;
  }

  Future<dynamic> uploadImage(File image) {
    final StorageReference firebaseRefrance =
        FirebaseStorage.instance.ref().child(user.id.toString() + '.jpg');
    final StorageUploadTask task = firebaseRefrance.putFile(image);
    task.onComplete.then((s) {
      s.ref.getDownloadURL().then((value) {
        _user.photo = value;
        updateUser(_user);
        notifyListeners();
      });
    });
  }
}
