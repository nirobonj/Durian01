import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   title: const Text('Home Page'),
      // ),
      body: Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}
