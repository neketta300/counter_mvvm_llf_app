import 'package:flutter/material.dart';
import 'package:mvvm_counter_llf/ui/widgets/auth_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: AuthWidget.create());
  }
}
