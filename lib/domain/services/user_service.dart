import 'package:flutter/cupertino.dart';
import 'package:mvvm_counter_llf/domain/data_provider/user_data_provider.dart';
import 'package:mvvm_counter_llf/domain/entity/user.dart';

typedef UserSevriveOnUpdate = void Function(User);

class UserSevrive {
  final _userDataProvider = UserDataProvider();

  VoidCallback? _currentOnUpdate;

  void startListenUser(void Function(User) onUpdate) {
    final currentOnUpdate = () {
      onUpdate(_userDataProvider.user);
    };
    _currentOnUpdate = currentOnUpdate;
    _userDataProvider.addListener(currentOnUpdate);
    onUpdate(_userDataProvider.user);
    _userDataProvider.openConect();
  }

  void stopListenUser() {
    final currentOnUpdate = _currentOnUpdate;
    if (currentOnUpdate != null) {
      _userDataProvider.removeListener(currentOnUpdate);
    }
  }
}
