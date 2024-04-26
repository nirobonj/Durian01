import 'package:flutter/material.dart';
import 'setting_page.dart';

class DisplayPage extends StatelessWidget {
  final bool isHomePageVisible;
  const DisplayPage({Key? key, required this.isHomePageVisible})
      : super(key: key);
      
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 153),
      // appBar: AppBar(
      //   title: const Text('Display Page'),
      // ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('isHomePageVisible: $isHomePageVisible'),
                const SizedBox(height: 20),
                const Text(
                  'This is the display page',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
          Positioned(
            top: 50,
            right: 17,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingPage()),
                );
              },
              child: SizedBox(
                width: 40,
                height: 40,
                child: Image.asset('assets/settings.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
