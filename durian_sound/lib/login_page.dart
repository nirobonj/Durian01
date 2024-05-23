import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'signup_page.dart';
import 'home_page.dart';
import 'display_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:durian_sound/config.dart';

class UserController extends GetxController {
  RxString username = ''.obs;
  RxString password = ''.obs;

  void setUsername(String value) => username.value = value;
  void setPassword(String value) => password.value = value;
}

class LoginPage extends StatelessWidget {
  final bool isHomePageVisible;
  const LoginPage({super.key, required this.isHomePageVisible});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final UserController userController = Get.put(UserController());

    void showAlertDialog(BuildContext context, String title, String message) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // ปิด dialog
                },
                child: const Text('ตกลง'),
              ),
            ],
          );
        },
      );
    }

    void login(BuildContext context) async {
      String username = usernameController.text;
      String password = passwordController.text;

      final url = Uri.parse('${AppConfig.connUrl}/users/login/');

      try {
        final response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'login_username': username,
            'login_password': password,
          }),
        );

        if (response.statusCode == 200) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          bool? isHomePageVisible = prefs.getBool('isHomePageVisible') ?? true;
          userController.setUsername(username);
          userController.setPassword(password);
          if (kDebugMode) {
            print('Username: $username');
          }

          if (isHomePageVisible) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  isHomePageVisible: isHomePageVisible,
                ),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPage(
                  isHomePageVisible: isHomePageVisible,
                ),
              ),
            );
          }
          if (kDebugMode) {
            print('Login successful');
          }
        } else {
          // ไม่สำเร็จ: แสดง dialog แจ้งเตือน
          if (kDebugMode) {
            print('Login failed');
          }
          showAlertDialog(
              context, 'Login Failed', 'Invalid username or password');
        }
      } catch (e) {
        // เกิดข้อผิดพลาดในการเชื่อมต่อกับเซิร์ฟเวอร์
        if (kDebugMode) {
          print('Error: $e');
        }
        showAlertDialog(context, 'Error', 'An error occurred: $e');
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
      backgroundColor: const Color.fromARGB(255, 255, 250, 181),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 220,
              height: 200,
              child: Image.asset('assets/image/icon.PNG'),
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
