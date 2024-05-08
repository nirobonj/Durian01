import 'package:flutter/material.dart';
// import 'login_page.dart';
import 'home_page.dart';
import 'display_page.dart';

class SignupNextPage extends StatelessWidget {
  final bool isHomePageVisible;
  const SignupNextPage({super.key, required this.isHomePageVisible});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 153),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ลงทะเบียน',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: 220,
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'กรอกชื่อผู้ใช้',
                  labelText: 'ชื่อผู้ใช้',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: 220,
              height: 50,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'กรอกรหัสผ่าน',
                  labelText: 'รหัสผ่าน',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: 220,
              height: 50,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'ยืนยันรหัสผ่าน',
                  labelText: 'ยืนยันรหัสผ่าน',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (isHomePageVisible) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage(isHomePageVisible: isHomePageVisible,)),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DisplayPage(isHomePageVisible: false,)),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffffea00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'ลงทะเบียน',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
