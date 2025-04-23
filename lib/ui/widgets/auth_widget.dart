// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mvvm_counter_llf/domain/data_provider/auth_api_provider.dart';
import 'package:mvvm_counter_llf/domain/services/auth_service.dart';

enum _ViewModelAuthButtonState { canSubmit, authProcces, disable }

class _ViewModelState {
  final String authErrorTitle;
  final String login;
  final String password;
  final bool isAuthInProcess;
  _ViewModelAuthButtonState get authButtonState {
    if (isAuthInProcess) {
      return _ViewModelAuthButtonState.authProcces;
    } else if (login.isNotEmpty && password.isNotEmpty) {
      return _ViewModelAuthButtonState.canSubmit;
    } else {
      return _ViewModelAuthButtonState.disable;
    }
  }

  _ViewModelState({
    this.login = '',
    this.password = '',
    this.authErrorTitle = '',
    this.isAuthInProcess = false,
  });

  _ViewModelState copyWith({
    String? authErrorTitle,
    String? login,
    String? password,
    bool? isAuthInProcess,
  }) {
    return _ViewModelState(
      authErrorTitle: authErrorTitle ?? this.authErrorTitle,
      login: login ?? this.login,
      password: password ?? this.password,
      isAuthInProcess: isAuthInProcess ?? this.isAuthInProcess,
    );
  }
}

class _ViewModel extends ChangeNotifier {
  final _authService = AuthService();
  var _state = _ViewModelState();
  _ViewModelState get state => _state;

  void changeLogin(String login) {
    if (_state.login == login) return;
    _state = _state.copyWith(login: login);
    notifyListeners();
  }

  void changePassword(String password) {
    if (_state.password == password) return;
    _state = _state.copyWith(password: password);
    notifyListeners();
  }

  Future<void> onAuthButtonPressed() async {
    final login = _state.login;
    final password = _state.password;
    if (login.isEmpty || password.isEmpty) return;

    _state = _state.copyWith(authErrorTitle: '', isAuthInProcess: true);
    notifyListeners();
    try {
      await _authService.login(login, password);
      _state = _state.copyWith(authErrorTitle: '', isAuthInProcess: false);
      notifyListeners();
    } on AuthApiProviderIncorectLoginDataError {
      _state = _state.copyWith(
        authErrorTitle: 'Неправильный логин или пароль',
        isAuthInProcess: false,
      );
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(
        authErrorTitle: 'Ошибка логгирования. Попробуйте позже',
        isAuthInProcess: false,
      );
      notifyListeners();
    }
  }
}

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _ViewModel(),
      child: const AuthWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _LoginWidget(),
              SizedBox(height: 10),
              _PasswordWidget(),
              _ErrorWidget(),
              AuthButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginWidget extends StatelessWidget {
  const _LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    return TextField(
      onChanged: model.changeLogin,
      decoration: const InputDecoration(
        label: Text('Введите логин'),
        border: OutlineInputBorder(),
      ),
    );
  }
}

class _PasswordWidget extends StatelessWidget {
  const _PasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    return TextField(
      onChanged: model.changePassword,
      decoration: const InputDecoration(
        label: Text('Введите пароль'),
        border: OutlineInputBorder(),
      ),
    );
  }
}

//select обновляет только authErrorTitle
class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authErrorTitle = context.select(
      (_ViewModel value) => value._state.authErrorTitle,
    );
    return Text(authErrorTitle);
  }
}

class AuthButtonWidget extends StatelessWidget {
  const AuthButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authButtonState = context.select(
      (_ViewModel value) => value._state.authButtonState,
    );
    final model = context.read<_ViewModel>();
    final onPressed =
        authButtonState == _ViewModelAuthButtonState.canSubmit
            ? model.onAuthButtonPressed
            : null;
    final child =
        authButtonState == _ViewModelAuthButtonState.authProcces
            ? const CircularProgressIndicator()
            : const Text('Авторизоваться');
    return ElevatedButton(onPressed: onPressed, child: child);
  }
}
