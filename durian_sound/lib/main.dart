import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadIsHomePageVisible();
  }

  Future<void> _loadIsHomePageVisible() async {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Durian Sound Classify',
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
        ),
      ),
      home: _isLoading
          ? const SplashScreen()
          : const LoginPage(isHomePageVisible: true),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
