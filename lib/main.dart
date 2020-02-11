import 'package:flutter/material.dart';
import 'package:matrix_trading/screens/admin-home.dart';
import 'package:matrix_trading/screens/sign-in.dart';
import 'package:matrix_trading/screens/sign-up.dart';
import 'package:matrix_trading/screens/user-home.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var status = prefs.getString('email');

  runApp(
      MaterialApp(
        theme: ThemeData(
            primaryColor: Color(0xff1074bc)
        ),
        home: status==null?SignIn():UserHome(),
      )
  );
}
