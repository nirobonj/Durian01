import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
// import 'setting_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;
  // @override
  // void initState() {
  //   super.initState();
  //   _loadHomePageVisibility();
  // }
  @override
  void initState() {
    super.initState();
    _loadIsHomePageVisible();
  }

  // Future<void> _loadHomePageVisibility() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _isHomePageVisible = prefs.getBool('isHomePageVisible') ?? true;
  //     _isLoading = false;
  //   });
  // }
  // Future<void> _updateIsHomePageVisible(bool newValue) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('isHomePageVisible', newValue);
  //   setState(() {
  //   });
  // }

  Future<void> _loadIsHomePageVisible() async {
    setState(() {
      _isLoading = false;
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Durian Sound Classify',
  //     theme: ThemeData(
  //       inputDecorationTheme: const InputDecorationTheme(
  //         fillColor: Colors.white,
  //         filled: true,
  //       ),
  //     ),
  //     home: _isLoading
  //         ? const SplashScreen()
  //         : _isHomePageVisible
  //             ? const LoginPage(isHomePageVisible: true)
  //             : const SettingPage(),
  //     debugShowCheckedModeBanner: false,
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Durian Sound Classify',
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
        ),
      ),
      home: _isLoading
          ? const SplashScreen()
          : const LoginPage(
              isHomePageVisible:
                  true),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}


























// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'login_page.dart';
// import 'setting_page.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // return MaterialApp(
//     //   title: 'Durian Sound Classify',
//     //   theme: ThemeData(
//     //     inputDecorationTheme: const InputDecorationTheme(
//     //       fillColor: Colors.white,
//     //       filled: true,
//     //     ),
//     //   ),
//     //   home: FutureBuilder<bool>(
//     //     future: _getIsHomePageVisible(), // ใช้ฟังก์ชั่น _getIsHomePageVisible() เพื่อเรียกใช้ SharedPreferences
//     //     builder: (context, snapshot) {
//     //       if (snapshot.connectionState == ConnectionState.done) {
//     //         bool isHomePageVisible = snapshot.data ?? false;
//     //         return isHomePageVisible ? SettingPage() : LoginPage(isHomePageVisible: false,);
//     //       } else {
//     //         return const Scaffold(
//     //           body: Center(
//     //             child: CircularProgressIndicator(),
//     //           ),
//     //         );
//     //       }
//     //     },
//     //   ),
//     //   debugShowCheckedModeBanner: false,
//     // );
//     return MaterialApp(
//       title: 'Durian Sound Classify',
//       theme: ThemeData(
//         inputDecorationTheme: const InputDecorationTheme(
//           fillColor: Colors.white,
//           filled: true,
//         ),
//       ),
//       home: FutureBuilder<bool>(
//         future: _getIsHomePageVisible(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasData) {
//               // ตรวจสอบว่ามีข้อมูลที่ส่งมาหรือไม่
//               bool isHomePageVisible = snapshot.data ?? true;
//               return isHomePageVisible
//                   ? const SettingPage()
//                   : const LoginPage(isHomePageVisible: true);
//             } else {
//               return const LoginPage(
//                   isHomePageVisible:
//                       false);
//             }
//           } else {
//             return const Scaffold(
//               body: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           }
//         },
//       ),
//       debugShowCheckedModeBanner: false,
//     );
//   }

//   Future<bool> _getIsHomePageVisible() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getBool('isHomePageVisible') ?? true;
//   }
// }







/*import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:path_provider/path_provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Durian Sound Classify',
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
        ),
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: const Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String? _selectedProvince;
  String? _selectedType;
  final List<String> type = ['ล้ง', 'ผู้บริโภค', 'ผู้ขาย', 'ชาวสวน'];
  final List<String> provinces = [
    'กรุงเทพมหานคร',
    'กระบี่',
    'กาญจนบุรี',
    'ปทุมธานี',
    'กาฬสินธุ์',
    'กำแพงเพชร',
    'ขอนแก่น',
    'จันทบุรี',
    'ฉะเชิงเทรา',
    'ชลบุรี',
    'ชัยนาท',
    'ชัยภูมิ',
    'ชุมพร',
    'เชียงราย',
    'เชียงใหม่',
    'ตรัง',
    'ตราด',
    'ตาก',
    'นครนายก',
    'นครปฐม',
    'นครพนม',
    'นครราชสีมา',
    'นครศรีธรรมราช',
    'นครสวรรค์',
    'นนทบุรี',
    'นราธิวาส',
    'น่าน',
    'บึงกาฬ',
    'บุรีรัมย์',
    'ปทุมธาน',
    'ประจวบคีรีขันธ์',
    'ปราจีนบุรี',
    'ปัตตานี',
    'พระนครศรีอยุธยา',
    'พังงา',
    'พัทลุง',
    'พิจิตร',
    'พิษณุโลก',
    'เพชรบุรี',
    'เพชรบูรณ์',
    'ปทุมธาน',
    'ประจวบคีรีขันธ์',
    'ปราจีนบุรี',
    'ปัตตานี',
    'พระนครศรีอยุธยา',
    'พังงา',
    'พัทลุง',
    'พิจิตร',
    'พิษณุโลก',
    'เพชรบุรี',
    'เพชรบูรณ์',
    'ปทุมธาน',
    'ประจวบคีรีขันธ์',
    'ปราจีนบุรี',
    'ปัตตานี',
    'พระนครศรีอยุธยา',
    'พังงา',
    'พัทลุง',
    'พิจิตร',
    'พิษณุโลก',
    'เพชรบุรี',
    'เพชรบูรณ์',
    'แพร่',
    'พะเยา',
    'ภูเก็ต',
    'มหาสารคาม',
    'มุกดาหาร',
    'แม่ฮ่องสอน',
    'ยะลา',
    'ยโสธร',
    'ร้อยเอ็ด',
    'ระนอง',
    'ระยอง',
    'ราชบุรี',
    'ลพบุรี',
    'ลำปาง',
    'ลำพูน',
    'เลย',
    'ศรีสะเกษ',
    'สกลนคร',
    'สงขลา',
    'สตูล',
    'สมุทรปราการ',
    'สมุทรสงคราม',
    'สมุทรสาคร',
    'สระแก้ว',
    'สระบุรี',
    'สิงห์บุรี',
    'สุโขทัย',
    'สุพรรณบุรี',
    'สุราษฎร์ธานี',
    'สุรินทร์',
    'หนองคาย',
    'หนองบัวลำภู',
    'อ่างทอง',
    'อุดรธานี',
    'อุทัยธานี',
    'อุตรดิตถ์',
    'อุบลราชธานี',
    'อำนาจเจริญ',
  ];
  void next() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupNextPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffff8D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ลงทะเบียน',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40, // ปรับขนาดข้อความเป็น 40
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: 220,
              height: 50,
              child: TextField(
                // controller: _passwordController,
                // obscureText: true,
                decoration: InputDecoration(
                  hintText: 'กรอกชื่อ',
                  labelText: 'ชื่อ',
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
                // controller: _passwordController,
                // obscureText: true,
                decoration: InputDecoration(
                  hintText: 'กรอกนามสกุล',
                  labelText: 'นามสกุล',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 25),
            // SizedBox(
            //   width: 220,
            //   height: 40,
            //   child: TextField(
            //     // controller: _usernameController,
            //     decoration: InputDecoration(
            //       hintText: 'กรอกชื่อผู้ใช้',
            //       labelText: 'ชื่อผู้ใช้',
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(4),
            //       ),
            //       fillColor: Colors.white,
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 25),
            // SizedBox(
            //   width: 220,
            //   height: 40,
            //   child: TextField(
            //     // controller: _passwordController,
            //     // obscureText: true,
            //     decoration: InputDecoration(
            //       hintText: 'กรอกรหัสผ่าน',
            //       labelText: 'รหัสผ่าน',
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(4),
            //       ),
            //       fillColor: Colors.white,
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 25),
            SizedBox(
              width: 220,
              height: 50,
              child: TextField(
                // controller: _passwordController,
                // obscureText: true,
                decoration: InputDecoration(
                  hintText: 'กรอกเบอร์โทรศัพท์',
                  labelText: 'เบอร์โทรศัพท์',
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
              height: 65,
              child: DropdownButtonFormField<String>(
                value: _selectedProvince,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedProvince = newValue;
                  });
                },
                items: provinces.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: const Text('เลือกจังหวัด'),
                decoration: InputDecoration(
                  // hintText: 'กรุณาเลือกจังหวัด',
                  // labelText: 'กรุณาเลือกจังหวัด',
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
              height: 65,
              child: DropdownButtonFormField<String>(
                value: _selectedType,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedType = newValue;
                  });
                },
                items: type.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: const Text('เลือกประเภทผู้ใช้'),
                decoration: InputDecoration(
                  // hintText: 'กรุณาเลือกจังหวัด',
                  // labelText: 'กรุณาเลือกจังหวัด',
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
                onPressed: next,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffffea00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'ถัดไป',
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

class SignupNextPage extends StatefulWidget {
  SignupNextPage({Key? key}) : super(key: key);

  @override
  _SignupNextPageState createState() => _SignupNextPageState();
}

class _SignupNextPageState extends State<SignupNextPage> {
  void non() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffff8D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ลงทะเบียน',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40, // ปรับขนาดข้อความเป็น 40
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: 220,
              height: 50,
              child: TextField(
                // controller: _passwordController,
                // obscureText: true,
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
                // controller: _passwordController,
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
                // controller: _passwordController,
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
                onPressed: non,
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

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // เช็คว่า username และ password ถูกต้องหรือไม่
    if (username == 'admin' && password == 'password') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
      if (kDebugMode) {
        print('Login successful');
      }
    } else {
      if (kDebugMode) {
        print('Login failed');
      }
    }
  }

  void signup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffff8D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              width: 200,
              height: 200,
            ),
            SizedBox(
              width: 220,
              height: 50,
              child: TextField(
                controller: _usernameController,
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
                controller: _passwordController,
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
                onPressed: login,
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
                onPressed: signup,
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
