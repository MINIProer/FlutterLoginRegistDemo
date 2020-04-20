import 'package:flutter/material.dart';
import 'package:share_preference_demo/models/user_model.dart';
import 'package:share_preference_demo/tools/local_storage_tool.dart';
import 'dart:convert' as convert;

enum JRLoginInputErrorType { 
  correct, 
  error
}

class JRUserViewModel extends ChangeNotifier {
  List<JRUserModel> _users = [];

  List<JRUserModel> get users {
    return _users;
  }

  void add(JRUserModel userModel) {
    _users.add(userModel);
    notifyListeners();
  }

  void delete(JRUserModel userModel) {
    _users.remove(userModel);
    notifyListeners();
  }

  bool userExist(String userName, String passWord) {
    for (int i = 0; i < _users.length; i++) {
      JRUserModel userModel = _users[i];
      if (userName == userModel.username && passWord == userModel.password) {
        return true;
      }
    }
    return false;
  }

  JRLoginInputErrorType hasUser(String userName, String passWord) {
    for (int i = 0; i < _users.length; i++) {
      JRUserModel userModel = _users[i];
      if (userName == userModel.username && passWord == userModel.password) {
        return JRLoginInputErrorType.correct;
      } 
    }
    return JRLoginInputErrorType.error;
  }

  bool userNameExist(String userName) {
    for (int i = 0; i < _users.length; i++) {
      JRUserModel userModel = _users[i];
      if (userName == userModel.username) {
        return true;
      }
    }
    return false;
  }

  List<JRUserModel> findUsers(String keyword) {
    List<JRUserModel> userList = [];
    if (_users.length == 0 || _users == null) return [];
    for (int i = 0; i < _users.length; i++) {
      JRUserModel userModel = _users[i];
      if (userModel.username.contains(keyword)) {
        userList.add(userModel);
      }
    }
    return userList;
  }

  JRUserViewModel() {
    JRLocalStorage.get('UserList').then((res) {
      Map userListMap = convert.jsonDecode(res);
      List userList = userListMap['list'];

      for (var json in userList) {
        _users.add(JRUserModel.fromMap(json));
      }

      print('_user = $_users');
      notifyListeners();
    });
  }
}
