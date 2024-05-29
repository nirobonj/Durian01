import 'dart:convert';
import 'package:durian_sound/edit_form_page.dart';
import 'package:durian_sound/login_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'about_us_page.dart';
import 'config.dart';
import 'display_page.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool? isHomePageVisible;
  final String defaultUsername = Get.find<UserController>().username.value;
  final UserController userController = Get.find<UserController>();
  @override
  void initState() {
    super.initState();
    _loadHomePageVisibility();
    _loadUserCredentials();
  }

  Future<void> _loadHomePageVisibility() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isHomePageVisible = prefs.getBool('isHomePageVisible');
    });
  }

  Future<void> _loadUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? password = prefs.getString('password');

    setState(() {
      if (username != null) {
        userController.setUsername(username);
      }
      if (password != null) {
        userController.setPassword(password);
      }
    });
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username') ?? '';
    String password = prefs.getString('password') ?? '';
    try {
      final response = await http.post(
        Uri.parse('${AppConfig.connUrl}/users/logout/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
        'login_username': username,
        'login_password': password,
      }),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['status'] == 'success') {
          await prefs.clear();
          await prefs.setBool('isLoggedIn', false);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  LoginPage(isHomePageVisible: isHomePageVisible ?? true),
            ),
            (Route<dynamic> route) => false,
          );
        } else {
          _showErrorDialog(result['message']);
        }
      } else {
        _showErrorDialog('Server error: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorDialog('An error occurred: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> _showLogoutConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ยืนยันการออกจากระบบ'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('คุณแน่ใจหรือไม่ที่ต้องการออกจากระบบ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop(); 
              },
            ),
            TextButton(
              child: const Text('ตกลง'),
              onPressed: () {
                Navigator.of(context).pop(); 
                _logout(); 
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 153),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 248, 153),
        title: const Text(
          'การตั้งค่า',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPage(
                  isHomePageVisible: isHomePageVisible ?? true,
                ),
              ),
            ).then((value) {
              setState(() {
                isHomePageVisible = value ?? isHomePageVisible;
              });
            });
          },
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 350,
          height: 700,
          child: Card(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(' หน้าคำอธิบาย '),
                      Switch(
                        value: isHomePageVisible ?? true,
                        onChanged: (bool value) async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setBool('isHomePageVisible', value);
                          setState(() {
                            isHomePageVisible = value;
                          });
                        },
                        activeColor: const Color.fromARGB(255, 35, 184, 119),
                      ),
                    ],
                  ),
                  onTap: () async {
                    final newValue = !(isHomePageVisible ?? true);
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool('isHomePageVisible', newValue);
                    setState(() {
                      isHomePageVisible = newValue;
                      if (kDebugMode) {
                        print(
                          'Setting Page is now ${newValue ? 'open' : 'closed'}',
                        );
                      }
                    });
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text(' แก้ไขข้อมูลส่วนตัว'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditFormPage(defaultUsername: defaultUsername),
                      ),
                    );
                  },
                  trailing: const Icon(Icons.edit),
                ),
                const Divider(),
                ListTile(
                  title: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Version'),
                      Text('1.0'),
                    ],
                  ),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  title: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('เกี่ยวกับเรา'),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutUsPage()),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text('Logout'),
                  onTap: () {
                    _showLogoutConfirmationDialog();
                  },
                  trailing: const Icon(Icons.logout),
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
