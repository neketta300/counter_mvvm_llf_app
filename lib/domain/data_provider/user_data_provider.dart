import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvvm_counter_llf/domain/entity/user.dart';

class UserDataProvider extends ChangeNotifier {
  Timer? _timer;
  var _user = User(age: 0);

  User get user => _user;

  void openConect() {
    if (_timer != null) return;
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      _user = User(age: _user.age + 1);
      notifyListeners();
    });
  }

  void closeConect() {
    _timer?.cancel();
    _timer = null;
  }

  // Future<User> loadValue() async {
  //   final age = (await sharedPreferences).getInt('age') ?? 0;
  //   return User(age: age);
  // }

  // Future<void> saveValue(User user) async {
  //   (await sharedPreferences).setInt('age', user.age);
  // }
}
