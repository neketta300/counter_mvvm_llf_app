import 'dart:math';
import 'package:mvvm_counter_llf/domain/data_provider/user_data_provider.dart';
import 'package:mvvm_counter_llf/domain/entity/user.dart';

class UserSevrive {
  final _userDataProvider = UserDataProvider();
  var _user = User(age: 0);
  User get user => _user;

  Future<void> initialize() async {
    _user = await _userDataProvider.loadValue();
  }

  void incrementAge() async {
    _user = user.copyWith(age: user.age + 1);
    _userDataProvider.saveValue(_user);
  }

  void decrementAge() {
    _user = _user.copyWith(age: max(user.age - 1, 0));
    _userDataProvider.saveValue(_user);
  }
}
