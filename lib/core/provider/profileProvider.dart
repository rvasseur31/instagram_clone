import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class ProfileProvider with ChangeNotifier {
  List<dynamic> _userPictures = [];
  List<dynamic> get userPictures => _userPictures;

  String _userId;

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set isLoading(bool isloading) {
    _isLoading = isloading;
    notifyListeners();
  }

  ProfileProvider(this._userId);

  Future<void> getPictures() async {
    const url = "https://instagram-clone-ynov.herokuapp.com/getPictures";
    var response = await http.post(
      Uri.encodeFull(url),
      body: jsonEncode({"uid": _userId, "archived": false}),
      headers: {'Content-Type': 'application/json'},
    );
    _userPictures = json.decode(response.body)["json"];
    print(_userPictures);
    notifyListeners();
    isLoading = false;
  }
}
