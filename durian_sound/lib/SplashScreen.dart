import 'package:flutter/material.dart';
import 'dart:async';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showFirstImage = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          _showFirstImage = !_showFirstImage;
        });
        if (!_showFirstImage) {
          _timer.cancel(); 
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 250, 181),
      body: Center(
        child: AnimatedSwitcher(
          duration:
              const Duration(milliseconds: 400), 
          child: _showFirstImage
              ? Image.asset('assets/image/koopoo.png', key: const Key('koopoo'))
              : Image.asset('assets/image/kp.png', key: const Key('kp')),
        ),
      ),
    );
  }
}
