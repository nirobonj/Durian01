import 'package:flutter/material.dart';
import 'dart:async';
import 'login_page.dart';
import 'SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

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
    // ทำการ delay 5 วินาที
    await Future.delayed(const Duration(seconds: 8));
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
          fillColor: Color.fromARGB(255, 255, 250, 181),
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






// import 'package:flutter/material.dart';
// import 'login_page.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool _isLoading = true;
//   @override
//   void initState() {
//     super.initState();
//     _loadIsHomePageVisible();
//   }

//   Future<void> _loadIsHomePageVisible() async {
//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Durian Sound Classify',
//       theme: ThemeData(
//         inputDecorationTheme: const InputDecorationTheme(
//           fillColor: Colors.white,
//           filled: true,
//         ),
//       ),
//       home: _isLoading
//           ? const SplashScreen()
//           : const LoginPage(
//               isHomePageVisible:
//                   true),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }