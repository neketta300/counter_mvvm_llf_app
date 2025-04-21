// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final int age;

  User({required this.age});

  User copyWith({int? age}) {
    return User(age: age ?? this.age);
  }
}

class UserSevrive {
  var _user = User(age: 0);
  User get user => _user;

  Future<void> loadValue() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final age = sharedPreferences.getInt('age') ?? 0;
    _user = User(age: age);
  }

  void incrementAge() async {
    _user = _user.copyWith(age: _user.age + 1);
  }

  void saveValue() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('age', _user.age);
  }

  void decrementAge() async {
    _user = _user.copyWith(age: max(_user.age - 1, 0));
  }
}

class ViewModelState {
  final String ageTitle;

  ViewModelState({required this.ageTitle});
}

class ViewModel extends ChangeNotifier {
  final _userService = UserSevrive();

  var _state = ViewModelState(ageTitle: '');
  ViewModelState get state => _state;

  void loadValue() async {
    await _userService.loadValue();
    _updateState();
  }

  ViewModel() {
    loadValue();
  }

  Future<void> onIncrementButtonPressed() async {
    _userService.incrementAge();
    _updateState();
  }

  Future<void> onDecrementButtonPressed() async {
    _userService.decrementAge();
    _updateState();
  }

  void _updateState() {
    final user = _userService._user;
    _state = ViewModelState(ageTitle: user.age.toString());
    notifyListeners();
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              _AgeTitle(),
              _AgeIncrementButton(),
              _AgeDecrementButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AgeTitle extends StatelessWidget {
  const _AgeTitle();

  @override
  Widget build(BuildContext context) {
    final title = context.select((ViewModel vm) => vm.state.ageTitle);
    return Text(title);
  }
}

class _AgeIncrementButton extends StatelessWidget {
  const _AgeIncrementButton();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ViewModel>();
    return ElevatedButton(
      onPressed: viewModel.onIncrementButtonPressed,
      child: const Text('+'),
    );
  }
}

class _AgeDecrementButton extends StatelessWidget {
  const _AgeDecrementButton();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ViewModel>();
    return ElevatedButton(
      onPressed: viewModel.onDecrementButtonPressed,
      child: const Text('-'),
    );
  }
}
