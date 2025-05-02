import 'package:flutter/material.dart';
import 'package:mvvm_counter_llf/ui/widgets/auth_widget.dart';
import 'package:mvvm_counter_llf/ui/widgets/loader_widget.dart';
import 'package:mvvm_counter_llf/ui/widgets/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoaderWidget.create(),
      // routes: {'loader': (_) => LoaderWidget.create()},
      onGenerateRoute: (settings) {
        if (settings.name == 'auth') {
          return PageRouteBuilder(
            pageBuilder:
                (context, animation1, animation2) => AuthWidget.create(),
          );
        } else if (settings.name == 'mainScreen') {
          return PageRouteBuilder(
            pageBuilder:
                (context, animation1, animation2) => MainScreen.create(),
          );
        } else if (settings.name == 'loader') {
          return PageRouteBuilder(
            pageBuilder:
                (context, animation1, animation2) => LoaderWidget.create(),
          );  
        }
      },
    );
  }
}
