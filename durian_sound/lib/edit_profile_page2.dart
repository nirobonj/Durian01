// C:\xampp\htdocs\Durian01\durian_sound\lib\edit_profile_page.dart
//useeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
import 'package:durian_sound/config.dart';
import 'package:durian_sound/login_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String? _selectedProvince;
  String? _selectedType;
  final UserController userController = Get.find<UserController>();
  final List<String> type = ['ล้ง', 'ผู้บริโภค', 'ผู้ขาย', 'ชาวสวน'];

  final List<String> provinces = [
    'กรุงเทพมหานคร','กระบี่','กาญจนบุรี','ปทุมธานี','กาฬสินธุ์','กำแพงเพชร',
    'ขอนแก่น','จันทบุรี','ฉะเชิงเทรา','ชลบุรี','ชัยนาท','ชัยภูมิ','ชุมพร','เชียงราย',
    'เชียงใหม่','ตรัง','ตราด','ตาก','นครนายก','นครปฐม','นครพนม','นครราชสีมา',
    'นครศรีธรรมราช','นครสวรรค์','นนทบุรี','นราธิวาส','น่าน','บึงกาฬ','บุรีรัมย์',
    'ปทุมธานี','ประจวบคีรีขันธ์','ปราจีนบุรี','ปัตตานี','พังงา','พัทลุง','พิจิตร',
    'พิษณุโลก','เพชรบุรี','เพชรบูรณ์','แพร่','พะเยา','ภูเก็ต','มหาสารคาม',
    'มุกดาหาร','แม่ฮ่องสอน','ยะลา','ยโสธร','ร้อยเอ็ด','ระนอง','ระยอง','ราชบุรี',
    'ลพบุรี','ลำปาง','ลำพูน','เลย','ศรีสะเกษ','สกลนคร','สงขลา','สตูล',
    'สมุทรปราการ','สมุทรสงคราม','สมุทรสาคร','สระแก้ว','สระบุรี','สิงห์บุรี',
    'สุโขทัย','สุพรรณบุรี','สุราษฎร์ธานี','สุรินทร์','หนองคาย','หนองบัวลำภู',
     'อ่างทอง','อุดรธานี','อุทัยธานี','อุตรดิตถ์','อุบลราชธานี','อำนาจเจริญ',
  ];
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

// ฟังก์ชันเพิ่มเติมเพื่อแสดงข้อมูลใน TextField หรือ DropdownButtonFormField
  void fillFormFields(Map<String, dynamic> userData) {
    setState(() {
      _firstnameController.text = userData['firstname'];
      _lastnameController.text = userData['lastname'];
      _usernameController.text = userData['username'];
      _phoneController.text = userData['phone'];
      _selectedProvince = userData['province'];
      _selectedType = userData['type'];
    });
  }

  Future<void> fetchData() async {
    try {
      var response = await http.get(
          Uri.parse('${AppConfig.connUrl}/users/edit/'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        fillFormFields(data);
      } else {
        if (kDebugMode) {
          print('Failed to fetch data. Error: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
    }
  }

  Future<void> sendDataToServer() async {
    try {
      var response = await http.get(
        Uri.parse('${AppConfig.connUrl}/users/edit/'),
        headers: {
          'username': userController.username.value,
          'password': userController.password.value,
        },
      );
      if (kDebugMode) {
        print('Username: ${userController.username.value}');
        print('Password: ${userController.password.value}');
      }

      if (response.statusCode == 200) {
        json.decode(response.body);
      } else {
        if (kDebugMode) {
          print('Failed to fetch data. Error: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedProvince = provinces[0];
    _selectedType = type[0];
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 248, 153),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 248, 153),
        title: const Text(
          'ข้อมูลส่วนตัว',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 220,
              height: 50,
              child: TextField(
                // controller: _firstnameController,
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
                // controller: _lastnameController,
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
                // controller: _usernameController,
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
                obscureText: true, // เพื่อซ่อนรหัสผ่าน
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
            // const SizedBox(height: 10),
            // SizedBox(
            //   width: 220,
            //   height: 50,
            //   child: TextField(
            //     obscureText: true,
            //     decoration: InputDecoration(
            //       hintText: 'ยืนยันรหัสผ่าน',
            //       labelText: 'ยืนยันรหัสผ่าน',
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(4),
            //       ),
            //       fillColor: Colors.white,
            //     ),
            //   ),
            // ),
            const SizedBox(height: 10),
            SizedBox(
              width: 220,
              height: 50,
              child: TextField(
                // controller: _phoneController,
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  fillColor: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 20),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  sendDataToServer();
                }, // Pass context here
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffffea00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'บันทึกข้อมูล',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
