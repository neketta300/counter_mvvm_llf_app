import 'package:mvvm_counter_llf/domain/data_provider/user_data_provider.dart';
import 'package:mvvm_counter_llf/domain/entity/user.dart';

typedef UserSevriveOnUpdate = void Function(User);

class UserSevrive {
  final _userDataProvider = UserDataProvider();

  Stream<User> get userStream => _userDataProvider.userStream;
  User get user => _userDataProvider.user;

  void openConnect() => _userDataProvider.openConect();

  void closeConnect() => _userDataProvider.closeConect();
}
