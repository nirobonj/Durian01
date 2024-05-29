import 'package:flutter/services.dart'; 
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_page.dart';
import 'package:durian_sound/config.dart';
import 'package:flutter/foundation.dart';

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

  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();

  Future<List<String>> fetchProvinces() async {
    final response = await http.get(Uri.parse('${AppConfig.connUrl}/users/pro-mstr/'));
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body, reviver: (key, value) {
        if (value is String) {
          return utf8.decode(value.runes.toList());
        }
        return value;
      });

      if (data is Map<String, dynamic> && data.containsKey('province_descs') && data['province_descs'] is List<dynamic>) {
        final provinces = data['province_descs'] as List<dynamic>;
        return provinces.map((province) => province as String).toList();
      } else {
        throw Exception('Invalid data format');
      }
    } else {
      throw Exception('Failed to load provinces');
    }
  }

  void _sendDataToServer() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('รหัสผ่านไม่ตรงกัน'),
            content: const Text('กรุณาใส่รหัสผ่านและการยืนยันรหัสผ่านให้ตรงกัน'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); 
                },
                child: const Text('ตกลง'),
              ),
            ],
          );
        },
      );
      return;
    }

    Map<String, dynamic> data = {
      'register_fname': _firstnameController.text,
      'register_lname': _lastnameController.text,
      'register_tel': _phoneController.text,
      'register_province': _provinceController.text,
      'register_types': _selectedType,
      'register_username': _usernameController.text,
      'register_password': _passwordController.text,
    };

    String jsonData = json.encode(data);

    try {
      var response = await http.post(
        Uri.parse('${AppConfig.connUrl}/users/register/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonData,
      );
      if (kDebugMode) {
        print(response.statusCode);
      }

      if (response.statusCode == 201) {
        if (kDebugMode) {
          print('Data sent successfully');
        }

        setState(() {
          next(context);
        });
      } else {
        if (kDebugMode) {
          print('Failed to send data. Error: ${response.statusCode}');
        }
      }
    } catch (e) {
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
        ),
      ),
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
                inputFormatters: [LengthLimitingTextInputFormatter(50)],
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
                inputFormatters: [LengthLimitingTextInputFormatter(50)],
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
                inputFormatters: [LengthLimitingTextInputFormatter(20)],
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
                inputFormatters: [LengthLimitingTextInputFormatter(20)],
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
                controller: _confirmPasswordController,
                inputFormatters: [LengthLimitingTextInputFormatter(20)],
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
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10)
                ],
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
              child: FutureBuilder<List<String>>(
                future: fetchProvinces(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (_selectedProvince == null && snapshot.data!.isNotEmpty) {
                      _selectedProvince = snapshot.data!.first;
                    }

                    return DropdownButtonFormField<String>(
                      value: _selectedProvince,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedProvince = value;
                          _provinceController.text = value!;
                        });
                      },
                      items: snapshot.data!
                          .map<DropdownMenuItem<String>>((String value) {
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
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return CircularProgressIndicator(); 
                },
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
            ElevatedButton(
              onPressed: _sendDataToServer,
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
