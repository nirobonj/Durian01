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
      isHomePageVisible =
          prefs.getBool('isHomePageVisible');
    });
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
                  onTap: () {
                  },
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
                      MaterialPageRoute(builder: (context) => const AboutUsPage()),
                    );
                  },
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
