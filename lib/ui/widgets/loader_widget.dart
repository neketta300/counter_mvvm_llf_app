import 'package:flutter/material.dart';
import 'package:mvvm_counter_llf/domain/services/auth_service.dart';
import 'package:provider/provider.dart';

class _ViewModel {
  final _authService = AuthService();
  BuildContext context;
  _ViewModel(this.context) {
    init();
  }

  Future<void> init() async {
    final isAuth = await _authService.checkAuth();
    if (isAuth) {
      _goToAppScreen();
    } else {
      _goToAuthScreen();
    }
  }

  void _goToAuthScreen() {
    Navigator.of(context).pushNamedAndRemoveUntil('auth', (route) => false);
  }

  void _goToAppScreen() {
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil('mainScreen', (route) => false);
  }
}

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  static Widget create() {
    return Provider(
      create: (BuildContext context) => _ViewModel(context),
      lazy: false,
      child: const LoaderWidget(),
    );
  }
}
