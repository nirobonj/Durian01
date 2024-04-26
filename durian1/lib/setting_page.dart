import 'package:flutter/material.dart';
import 'edit_profile_page.dart';
import 'display_page.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State {
  bool isHomePageVisible = false;

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
          icon: Icon(Icons.arrow_back),
          // onPressed: () {
          //   Navigator.pop(context, isHomePageVisible);
          // },
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPage(
                  isHomePageVisible: isHomePageVisible,
                ),
              ),
            ).then((value) {
              // เมื่อกลับมาจากหน้า DisplayPage
              setState(() {
                isHomePageVisible = value ??
                    isHomePageVisible; // ใช้ค่าเดิมหากไม่มีการเปลี่ยนแปลง
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
                  onTap: () async {
                    final newValue = !isHomePageVisible;
                    setState(() {
                      isHomePageVisible = newValue;
                      print(
                          'Setting Page is now ${newValue ? 'open' : 'closed'}');
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
          setState(() {
            isHomePageVisible = !isHomePageVisible;
          });
        },
        child: Icon(isHomePageVisible ? Icons.close : Icons.home),
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
