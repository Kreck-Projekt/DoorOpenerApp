import 'package:flutter/material.dart';
import 'package:raspberry_pi_door_opener/frontend/screens/password_auth_screen.dart';
import 'package:raspberry_pi_door_opener/frontend/screens/password_set_screen.dart';
import 'package:raspberry_pi_door_opener/utils/other/data_manager.dart';

import 'home_screen.dart';

class InitApp extends StatefulWidget {
  @override
  _InitAppState createState() => _InitAppState();
}

class _InitAppState extends State<InitApp> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    bool first = await DataManager().getFirst();
    print(first);
    if (first) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>
              SetPassword() /*Homescreen()  OnboardingScreen()*/),
      );
    } else {
      print('test');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => PasswordAuth(
            route: Homescreen(),
            label: 'password_auth_password_label',
            explanation: 'password_auth_explanation',
            hint: 'password_auth_password_hint',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(
          Icons.vpn_key_outlined,
          size: 200,
        ),
      ),
    );
  }
}