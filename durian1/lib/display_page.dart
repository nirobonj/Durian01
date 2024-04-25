import 'package:flutter/material.dart';

class DisplayPage extends StatelessWidget {
  const DisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display Page'),
      ),
      body: const Center(
        child: Text(
          'This is the display page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
