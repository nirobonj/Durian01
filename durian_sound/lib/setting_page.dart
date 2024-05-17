import 'package:durian_sound/login_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_profile_page.dart';
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
  bool? isHomePageVisible; // เปลี่ยนเป็น null แทน true
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
          prefs.getBool('isHomePageVisible'); // ไม่มีการกำหนดค่าเริ่มต้น
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
                // Text('isHomePageVisible: ${isHomePageVisible ?? "null"}'),

                // ListTile(
                //   title: Text(
                //       ' หน้าคำอธิบาย ${isHomePageVisible ?? true ? 'เปิด' : 'ปิด'}'),
                //   onTap: () async {
                //     final newValue = !(isHomePageVisible ?? true);
                //     SharedPreferences prefs =
                //         await SharedPreferences.getInstance();
                //     await prefs.setBool('isHomePageVisible',
                //         newValue); // บันทึกค่าใหม่ใน SharedPreferences
                //     setState(() {
                //       isHomePageVisible = newValue;
                //       if (kDebugMode) {
                //         print(
                //             'Setting Page is now ${newValue ? 'open' : 'closed'}');
                //       }
                //     });
                //   },
                // ),
                // ListTile(
                //   title: Row(
                //     children: [
                //       const Text(' หน้าคำอธิบาย '),
                //       Switch(
                //         value: isHomePageVisible ?? true,
                //         onChanged: (bool value) async {
                //           SharedPreferences prefs =
                //               await SharedPreferences.getInstance();
                //           await prefs.setBool('isHomePageVisible', value);
                //           setState(() {
                //             isHomePageVisible = value;
                //           });
                //         },
                //         activeColor: Color.fromARGB(255, 66, 204, 144),
                //       ),
                //     ],
                //   ),
                //   onTap: () async {
                //     final newValue = !(isHomePageVisible ?? true);
                //     SharedPreferences prefs =
                //         await SharedPreferences.getInstance();
                //     await prefs.setBool('isHomePageVisible', newValue);
                //     setState(() {
                //       isHomePageVisible = newValue;
                //       if (kDebugMode) {
                //         print(
                //             'Setting Page is now ${newValue ? 'open' : 'closed'}');
                //       }
                //     });
                //   },
                // ),
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => EditPage()),
                    // );
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
                // const Divider(),
                // ListTile(
                //   title: const Text('about us'),
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => EditPage()),
                //     );
                //   },
                //   // trailing: const Icon(Icons.add),
                // ),
                
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
                    // ใส่โค้ดที่ต้องการให้ทำงานเมื่อคลิกที่รายการ Privacy ตรงนี้
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
                      MaterialPageRoute(builder: (context) => AboutUsPage()),
                    );
                  },
                ),

                const Divider(),
                const SizedBox(height: 320),

                // const Text(
                //   'about us',
                //   style: TextStyle(
                //       color: Colors.black,
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold),
                //   textAlign: TextAlign.center,
                // ),
                // Container(
                //   width: 25,
                //   height: 25,
                //   child: Image.asset(
                //     'assets/DoubleM.png',
                //     fit: BoxFit
                //         .contain, // หรือใช้ BoxFit.fill, BoxFit.cover, หรือตัวเลือกอื่น ๆ ตามความต้องการ
                //   ),
                // ),
                // const SizedBox(height: 5),
                // const Text(
                //   'Develop by Double M Technology Management Co.ltd\nCopyright 2024',
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontSize: 12,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                // const SizedBox(height: 15),

                // const SizedBox(height: 20),

                // // ข้อความ "เกี่ยวกับเรา"
                // Text(
                //   'About Us',
                //   style: TextStyle(
                //     fontSize: 16,
                //     fontWeight: FontWeight.bold,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                // const SizedBox(height: 10),

                // // ข้อความเนื้อหา
                // Text(
                //   'Develop by Double M Technology Management Co.ltd\ncopyright 2024',
                //   style: TextStyle(
                //     fontSize: 12,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                // Container(
                //   width: 25,
                //   height: 25,
                //   child: Image.asset('assets/DoubleM.png'),
                // ),
                const SizedBox(width: 10),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center, // จัดกึ่งกลาง
                //   children: [
                //     // const Divider(),
                //     Text(
                //       'About Us',
                //       style: TextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     // const Divider(),
                //     const SizedBox(width: 10),
                //     Text(
                //       'Develop by Double M Technology Management Co.ltd \nwww.doublemtech.com',
                //       style: TextStyle(
                //         fontSize: 12,
                //       ),
                //       textAlign: TextAlign.center,
                //     ),
                //     const SizedBox(width: 10),
                //     Container(
                //       width: 100,
                //       height: 40,
                //       child: Image.asset('assets/image/DoubleM.png'),
                //     ),
                //     const SizedBox(width: 10),
                //     Text(
                //       '©copyright 2024',
                //       style: TextStyle(
                //         fontSize: 10,
                //       ),
                //       textAlign: TextAlign.right,
                //     ),
                //   ],
                // ),
                
                // เพิ่มรายการอื่นๆ ตามต้องการ
              ],
            ),
          ),
        ),
      ),
    );
  }
}
