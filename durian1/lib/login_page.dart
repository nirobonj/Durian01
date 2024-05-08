import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'signup_page.dart';
import 'home_page.dart';
import 'display_page.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

class LoginPage extends StatelessWidget {
  final bool isHomePageVisible; // เปลี่ยนเป็น bool?
  const LoginPage({super.key, required this.isHomePageVisible});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    void login(BuildContext context) async {
      // เปลี่ยนให้ฟังก์ชั่น login เป็น asynchronous
      String username = usernameController.text;
      String password = passwordController.text;

      if (username == 'b' && password == 'b') {
        SharedPreferences prefs =
            await SharedPreferences.getInstance(); // อ่านค่า SharedPreferences
        bool? isHomePageVisible = prefs.getBool('isHomePageVisible') ??
            true; // ใช้ค่าจาก SharedPreferences
        if (isHomePageVisible) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      isHomePageVisible: isHomePageVisible,
                    )),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DisplayPage(isHomePageVisible: isHomePageVisible)),
          );
        }
        if (kDebugMode) {
          print('Login successful');
        }
      } else {
        if (kDebugMode) {
          print('Login failed');
        }
      }
    }

    void signup(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const SignupPage(isHomePageVisible: true)),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 248, 153),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text('isHomePageVisible: $isHomePageVisible'),
            // const SizedBox(
            //   width: 200,
            //   height: 200,

            // ),
            Container(
              width: 220,
              height: 200,
              color: const Color.fromARGB(255, 255, 214, 92), // เลือกสีที่คุณต้องการ
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: 220,
              height: 50,
              child: TextField(
                controller: usernameController,
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
                controller: passwordController,
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
            const SizedBox(height: 50),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                onPressed: () => login(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffffea00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'เข้าสู่ระบบ',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                onPressed: () => signup(context),
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
                      fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}










/*import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'signup_page.dart';
import 'home_page.dart';
import 'display_page.dart';

class LoginPage extends StatelessWidget {
  final bool isHomePageVisible; // เปลี่ยนเป็น bool?
  const LoginPage({super.key, required this.isHomePageVisible});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController(text: 'admin');
    TextEditingController passwordController = TextEditingController(text: 'password');

    void login(BuildContext context) {
      String username = usernameController.text;
      String password = passwordController.text;

      if (username == 'admin' && password == 'password') {
        if (isHomePageVisible) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage(isHomePageVisible: isHomePageVisible,)),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DisplayPage(isHomePageVisible: isHomePageVisible)),
          );
        }
        if (kDebugMode) {
          print('Login successful');
        }
      } else {
        if (kDebugMode) {
          print('Login failed');
        }
      }
    }

    void signup(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const SignupPage(isHomePageVisible: true)),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 153),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('isHomePageVisible: $isHomePageVisible'),
            const SizedBox(
              width: 200,
              height: 200,
            ),
            SizedBox(
              width: 220,
              height: 50,
              child: TextField(
                controller: usernameController,
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
                controller: passwordController,
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
            const SizedBox(height: 50),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                onPressed: () => login(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffffea00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'เข้าสู่ระบบ',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                onPressed: () => signup(context),
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
                      fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/










/*
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'signup_page.dart';
import 'home_page.dart';
import 'display_page.dart';

class LoginPage extends StatelessWidget {
  final bool isHomePageVisible;
  // LoginPage({super.key, required this.isHomePageVisible});
  LoginPage({super.key, required this.isHomePageVisible});
  // const LoginPage({Key? key, required this.isHomePageVisible})
  //     : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController(text: 'admin');
    TextEditingController passwordController = TextEditingController(text: 'password');

    void login(BuildContext context) {
      String username = usernameController.text;
      String password = passwordController.text;

      if (username == 'admin' && password == 'password') {
        if (isHomePageVisible) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DisplayPage(
                      isHomePageVisible: false,
                    )),
          );
        }
        if (kDebugMode) {
          print('Login successful');
        }
      } else {
        if (kDebugMode) {
          print('Login failed');
        }
      }
    }

    void signup(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const SignupPage(
                  isHomePageVisible: false,
                )),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 153),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('isHomePageVisible: $isHomePageVisible'),
            const SizedBox(
              width: 200,
              height: 200,
            ),
            SizedBox(
              width: 220,
              height: 50,
              child: TextField(
                controller: usernameController,
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
                controller: passwordController,
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
            const SizedBox(height: 50),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                onPressed: () => login(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffffea00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'เข้าสู่ระบบ',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                onPressed: () => signup(context),
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
                      fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} */
