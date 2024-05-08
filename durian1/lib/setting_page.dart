import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_profile_page.dart';
import 'display_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool? isHomePageVisible; // เปลี่ยนเป็น null แทน true

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
          height: 730,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditPage()),
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
                    // ใส่โค้ดที่ต้องการให้ทำงานเมื่อคลิกที่รายการ Privacy ตรงนี้
                  },
                ),

                const Divider(),
                // เพิ่มรายการอื่นๆ ตามต้องการ
              ],
            ),
          ),
        ),
      ),
    );
  }
}






















// import 'package:durian1/display_page.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'edit_profile_page.dart';
// import 'home_page.dart';
// import 'display_page.dart';

// class SettingPage extends StatefulWidget {
//   @override
//   _SettingPageState createState() => _SettingPageState();
// }

// class _SettingPageState extends State {
//   bool isHomePageVisible = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 255, 248, 153),
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 255, 248, 153),
//         title: const Text(
//           'การตั้งค่า',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Center(
//         child: SizedBox(
//           width: 350,
//           height: 730,
//           child: Card(
//             child: ListView(
//               children: <Widget>[
//                 Text('isHomePageVisible: $isHomePageVisible'),
//                 ListTile(
//                   title: const Text(' แก้ไขข้อมูลส่วนตัว'),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const EditPage()),
//                     );
//                   },
//                 ),
//                 const Divider(),
//                 ListTile(
//                   title: Text(
//                       ' หน้าคำอธิบาย ${isHomePageVisible ? 'เปิด' : 'ปิด'}'),
//                   // onTap: () async {
//                   //   final newValue = !isHomePageVisible;
//                   //   setState(() {
//                   //     isHomePageVisible = newValue;
//                   //     print(
//                   //         'Setting Page is now ${newValue ? 'open' : 'closed'}');
//                   //   });

//                   //   // ส่งค่ากลับไปยังหน้าที่เรียกใช้ SettingPage
//                   //   Navigator.pop(context, newValue);
//                   // },
//                   onTap: () async {
//                     final newValue = !isHomePageVisible;
//                     setState(() {
//                       isHomePageVisible = newValue;
//                       print(
//                           'Setting Page is now ${newValue ? 'open' : 'closed'}');
//                     });

//                     // ส่งค่ากลับไปยังหน้าที่เรียกใช้ (DisplayPage)
//                     Navigator.pop(context, isHomePageVisible);
//                   },
//                 ),
//                 const Divider(),
//                 ListTile(
//                   title: const Text(
//                       ' Version                                                1.0'),
//                   onTap: () {
//                     // ใส่โค้ดที่ต้องการให้ทำงานเมื่อคลิกที่รายการ Privacy ตรงนี้
//                   },
//                 ),
//                 const Divider(),
//                 // เพิ่มรายการอื่นๆ ตามต้องการ
//               ],
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         // onPressed: () {
//         //   if (isHomePageVisible) {
//         //     Navigator.push(
//         //       context,
//         //       MaterialPageRoute(builder: (context) => HomePage()),
//         //     );
//         //   } else {
//         //     Navigator.pop(context, isHomePageVisible);
//         //     if (kDebugMode) {
//         //       print('Successfully closed the SettingPage');
//         //     }
//         //   }
//         // },
//         // onPressed: () {
//         //   // ส่งค่ากลับไปยังหน้าที่เรียกใช้ SettingPage
//         //   Navigator.pop(context, isHomePageVisible);
//         // },
//         // onPressed: () {
//         //   // ส่งค่ากลับไปยังหน้าที่เรียกใช้ SettingPage
//         //   Navigator.pushReplacement(
//         //       context,
//         //       MaterialPageRoute(
//         //           builder: (context) =>
//         //               DisplayPage(isHomePageVisible: isHomePageVisible)));
//         // },
//         onPressed: () {
//           setState(() {
//             isHomePageVisible = !isHomePageVisible;
//           });
//         },
//         child: Icon(isHomePageVisible ? Icons.close : Icons.home),
//       ),
//     );
//   }
// }



















/*import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'edit_profile_page.dart';
import 'home_page.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State {
  bool isHomePageVisible = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // ตรวจสอบว่ามีการส่งค่า isHomePageVisible กลับมาหรือไม่
    final bool? receivedIsHomePageVisible =
        ModalRoute.of(context)?.settings.arguments as bool?;
    if (receivedIsHomePageVisible != null) {
      setState(() {
        isHomePageVisible = receivedIsHomePageVisible;
      });
    }
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
      ),
      body: Center(
        child: SizedBox(
          width: 350,
          height: 730,
          child: Card(
            child: ListView(
              children: <Widget>[
                Text('isHomePageVisible: $isHomePageVisible'),
                ListTile(
                  title: const Text(' แก้ไขข้อมูลส่วนตัว'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EditPage()),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  title: Text(
                      ' หน้าคำอธิบาย ${isHomePageVisible ? 'เปิด' : 'ปิด'}'),
                  onTap: () {
                    setState(() {
                      isHomePageVisible = !isHomePageVisible;
                      print(
                          'Setting Page is now ${isHomePageVisible ? 'open' : 'closed'}');
                    });
                  },
                ),

                const Divider(),
                ListTile(
                  title: const Text(
                      ' Version                                                1.0'),
                  onTap: () {
                    // ใส่โค้ดที่ต้องการให้ทำงานเมื่อคลิกที่รายการ Privacy ตรงนี้
                  },
                ),
                const Divider(),
                // เพิ่มรายการอื่นๆ ตามต้องการ
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isHomePageVisible) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else {
            Navigator.pop(context, isHomePageVisible);
            if (kDebugMode) {
              print('Successfully closed the SettingPage');
            }
          }
        },
        child: Icon(isHomePageVisible ? Icons.close : Icons.home),
      ),
    );
  }
}*/
