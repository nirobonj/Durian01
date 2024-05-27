import 'display_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'login_page.dart';
import 'SplashScreen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  Get.put(UserController());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _loadIsHomePageVisible();
    _loadInitialData();
  }

  Future<void> _loadIsHomePageVisible() async {
    // ทำการ delay 5 วินาที
    await Future.delayed(const Duration(seconds: 8));
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _loadInitialData() async {
    await Future.delayed(
        const Duration(seconds: 8));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    String username = prefs.getString('username') ?? '';
    String password = prefs.getString('password') ?? '';

    // Set user data in UserController
    final userController = Get.find<UserController>();
    userController.setUsername(username);
    userController.setPassword(password);
    print(username);
    setState(() {
      _isLoggedIn = isLoggedIn;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Durian Sound Classify',
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Color.fromARGB(255, 255, 250, 181),
          filled: true,
        ),
      ),
      home: _isLoading
          ? const SplashScreen()
          : const LoginPage(isHomePageVisible: true),
    );
  }
}

@override
Widget build(BuildContext context) {
  return const Scaffold(
    body: Center(
      child: CircularProgressIndicator(),
    ),
  );
}
