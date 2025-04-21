import 'package:flutter/material.dart';
import 'package:mvvm_counter_llf/ui/main_screen/main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (BuildContext context) => ViewModel(),
        child: const MainScreen(),
      ),
    );
  }
}
