import 'package:durian_sound/login_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'about_us_page.dart';
import 'display_page.dart';
import 'package:get/get.dart';
import 'package:durian_sound/edit_form_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool? isHomePageVisible;
  final String defaultUsername = Get.find<UserController>().username.value;
  @override
  void initState() {
    super.initState();
    _loadHomePageVisibility();
  }

  Future<void> _loadHomePageVisibility() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isHomePageVisible = prefs.getBool('isHomePageVisible');
    });
    if (kDebugMode) {
      print(defaultUsername);
    }
  }

   Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushAndRemoveUntil(
      context,
       MaterialPageRoute(
        builder: (context) => LoginPage(isHomePageVisible: isHomePageVisible ?? true),
      ),
      (Route<dynamic> route) => false,
    );
  }
Future<void> _showLogoutConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ยืนยันการออกจากระบบ'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('คุณแน่ใจหรือไม่ที่ต้องการออกจากระบบ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop(); // ปิดไดอะล็อก
              },
            ),
            TextButton(
              child: Text('ตกลง'),
              onPressed: () {
                Navigator.of(context).pop(); // ปิดไดอะล็อก
                _logout(); // เรียกใช้เมธอดออกจากระบบ
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


