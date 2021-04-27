import 'package:bloooc/blocs/provider.dart';
import 'package:bloooc/src/screens/login_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Login',
        home: Scaffold(
          body: LoginScreen(),
        ),
      ),
    );
  }
}
