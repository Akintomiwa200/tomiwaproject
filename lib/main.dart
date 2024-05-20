import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomiwa_project/Authpage/Login.dart';
import 'package:tomiwa_project/Authpage/Register.dart';
import 'package:tomiwa_project/Authpage/WelcomePage.dart';
import 'package:tomiwa_project/LanddingPage.dart';
import 'package:tomiwa_project/UserPage/Mainpage.dart';

import 'AdminPage/adminDashboard.dart';

late SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:
          sharedPref.getString("id") == null ? "landing" : "studentMainPage",
      routes: {
        "login": (context) => const LoginStudent(),
        "signup": (context) => const RegisterStudentPage(),
        "home": (context) => WelcomePage(),
        "adminpage": (context) => const AdminDashBoard(),
        "/": (context) => WelcomePage(),
        "studentMainPage": (context) => const StudentMainPage(),
        "landing": (context) => const LandingPage(),
      },
    );
  }
}