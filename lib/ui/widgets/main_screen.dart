import 'package:flutter/material.dart';
import 'package:mvvm_counter_llf/domain/services/auth_service.dart';
import 'package:mvvm_counter_llf/domain/services/user_service.dart';
import 'package:provider/provider.dart';

class _ViewModelState {
  final String ageTitle;

  _ViewModelState({required this.ageTitle});
}

class _ViewModel extends ChangeNotifier {
  final _userService = UserSevrive();
  final _authService = AuthService();

  var _state = _ViewModelState(ageTitle: '');
  _ViewModelState get state => _state;

  _ViewModel() {
    _userService.startListenUser((user) {
      _state = _ViewModelState(ageTitle: user.age.toString());
      notifyListeners();
    });
  }

  Future<void> onLoggoutPressed(BuildContext context) async {
    await _authService.logout();
    Navigator.of(context).pushNamedAndRemoveUntil('loader', (route) => false);
  }

  @override
  void dispose() {
    _userService.stopListenUser();
    super.dispose();
  }

  // Future<void> onIncrementButtonPressed() async {
  //   _userService.incrementAge();
  //   _updateState();
  // }

  // Future<void> onDecrementButtonPressed() async {
  //   _userService.decrementAge();
  //   _updateState();
  // }

  //   void _updateState() {
  //     final user = _userService.user;
  //     _state = _ViewModelState(ageTitle: user.age.toString());
  //     notifyListeners();
  //   }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _ViewModel(),
      child: const MainScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<_ViewModel>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => viewModel.onLoggoutPressed(context),
            child: const Text('Выход'),
          ),
        ],
      ),
      body: SafeArea(child: Center(child: _AgeTitle())),
    );
  }
}

class _AgeTitle extends StatelessWidget {
  const _AgeTitle();

  @override
  Widget build(BuildContext context) {
    final title = context.select((_ViewModel vm) => vm.state.ageTitle);
    return Text(title);
  }
}

// class _AgeIncrementButton extends StatelessWidget {
//   const _AgeIncrementButton();

//   @override
//   Widget build(BuildContext context) {
//     final viewModel = context.read<_ViewModel>();
//     return ElevatedButton(
//       onPressed: viewModel.onIncrementButtonPressed,
//       child: const Text('+'),
//     );
//   }
// }

// class _AgeDecrementButton extends StatelessWidget {
//   const _AgeDecrementButton();

//   @override
//   Widget build(BuildContext context) {
//     final viewModel = context.read<_ViewModel>();
//     return ElevatedButton(
//       onPressed: viewModel.onDecrementButtonPressed,
//       child: const Text('-'),
//     );
//   }
// }
