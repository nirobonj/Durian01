import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'signup_next_page.dart';
// import 'display_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  final bool isHomePageVisible;
  const SignupPage({super.key, required this.isHomePageVisible});
  @override
  State<SignupPage> createState() => _SignupPageState();
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
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future<void> _sendDataToServer() async {
    // เตรียมข้อมูลที่จะส่งไปยังเซิร์ฟเวอร์
    Map<String, dynamic> data = {
      'firstname': _firstnameController.text,
      'lastname': _lastnameController.text,
      'tel': _phoneController.text,
      'province': _selectedProvince,
      'type': _selectedType,
      'username': _usernameController.text,
      'password': _passwordController.text,
    };

    // แปลงข้อมูลเป็น JSON
    String jsonData = json.encode(data);

    try {
      // ส่ง request ไปยังเซิร์ฟเวอร์
      var response = await http.post(
        Uri.parse('http://192.168.9.44:3000/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonData,
      );
      if (kDebugMode) {
        print(response.statusCode);
      }

      // ตรวจสอบสถานะการตอบรับจากเซิร์ฟเวอร์
      if (response.statusCode == 201) {
        // หากสำเร็จแสดงข้อความ
        if (kDebugMode) {
          print('Data sent successfully');
        }
        // นำผู้ใช้ไปยังหน้าถัดไป
        // next(context);
        setState(() {
          next(context);
        });
      } else {
        // หากไม่สำเร็จแสดงข้อความแสดงว่ามีข้อผิดพลาด
        if (kDebugMode) {
          print('Failed to send data. Error: ${response.statusCode}');
        }
      }
    } catch (e) {
      // หากเกิดข้อผิดพลาดในการส่งข้อมูล
      if (kDebugMode) {
        print('Error sending data: $e');
      }
    }
  }

  void next(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const LoginPage(
                isHomePageVisible: false,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 248, 153),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ลงทะเบียน',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 220,
              height: 50,
              child: TextField(
                controller: _firstnameController,
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
            const SizedBox(height: 10),
            SizedBox(
              width: 220,
              height: 50,
              child: TextField(
                controller: _lastnameController,
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
            const SizedBox(height: 10),
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
            const SizedBox(height: 10),
            SizedBox(
              width: 220,
              height: 50,
              child: TextField(
                obscureText: true,
                controller: _passwordController,
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
            const SizedBox(height: 10),
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
            const SizedBox(height: 10),
            SizedBox(
              width: 220,
              height: 50,
              child: TextField(
                controller: _phoneController,
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
            const SizedBox(height: 10),
            SizedBox(
              width: 220,
              height: 65,
              child: DropdownButtonFormField<String>(
                value: _selectedProvince,
                onChanged: (String? newValue) {
                  // Your dropdown button code...
                  _selectedProvince = newValue;
                },
                items: provinces.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: const Text('เลือกจังหวัด'),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 220,
              height: 65,
              child: DropdownButtonFormField<String>(
                value: _selectedType,
                onChanged: (String? newValue) {
                  // Your dropdown button code...
                  _selectedType = newValue;
                },
                items: type.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    // value: _selectedType,
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: const Text('เลือกประเภทผู้ใช้'),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  fillColor: Colors.white,
                ),
              ),
            ),
            // const SizedBox(height: 25),
            // SizedBox(
            //   width: 220,
            //   height: 50,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => DisplayPage(
            //                   isHomePageVisible: false,
            //                 )),
            //       );
            //     }, // Pass context here
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: const Color(0xffffea00),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //     ),
            //     child: const Text(
            //       'ลงทะเบียน',
            //       style: TextStyle(
            //         color: Colors.black,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 20,
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  _sendDataToServer, // เรียกใช้ _sendDataToServer() เมื่อกดปุ่ม
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
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}











/*
import 'package:flutter/material.dart';
import 'signup_next_page.dart';

class SignupPage extends StatefulWidget {
  final bool isHomePageVisible;
  const SignupPage({Key? key, required this.isHomePageVisible})
      : super(key: key);
  @override
  State<SignupPage> createState() => _SignupPageState();
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

  void next(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const SignupNextPage(
                isHomePageVisible: false,
              )),
    );
  }

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
                  // Your dropdown button code...
                },
                items: provinces.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: const Text('เลือกจังหวัด'),
                decoration: InputDecoration(
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
                  // Your dropdown button code...
                },
                items: type.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: const Text('เลือกประเภทผู้ใช้'),
                decoration: InputDecoration(
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
                onPressed: () => next(context), // Pass context here
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
}*/

















/*import 'package:flutter/material.dart';
import 'signup_next_page.dart';

class SignupPage extends StatelessWidget {
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
                fontSize: 40,
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
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                onPressed: () => next, // Adjusted onPressed callback
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
                    fontSize: 20,
                  ),
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
}*/