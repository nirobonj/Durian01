import 'package:durian_sound/config.dart';
import 'package:durian_sound/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  // String username = Get.find<UserController>().username.value;

  // final String defaultUsername = "saran";

  final String defaultUsername = Get.find<UserController>().username.value;

  String message = '';
  Map<String, dynamic>? userData;
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _telController = TextEditingController();
  TextEditingController _provinceController = TextEditingController();
  TextEditingController _typesController = TextEditingController();

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('${AppConfig.connUrl}/users/edit/$defaultUsername'),
    );
    print(defaultUsername);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        message = responseData['message'] ?? '';
        userData = responseData['data'];
        _firstnameController.text = userData?['firstname'] ?? '';
        _lastnameController.text = userData?['lastname'] ?? '';
        _usernameController.text = userData?['username'] ?? '';
        _telController.text = userData?['tel'] ?? '';
        _provinceController.text = userData?['province'] ?? '';
        _typesController.text = userData?['types'] ?? '';
      });
    } else {
      print('Failed to fetch data.');
    }
  }

  Future<void> saveData() async {
    final url = Uri.parse('${AppConfig.connUrl}/users/edit/$defaultUsername');

    try {
      final response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'firstname': _firstnameController.text,
          'lastname': _lastnameController.text,
          'tel': _telController.text,
          'province': _provinceController.text,
          'types': _typesController.text,
        }),
      );

      if (response.statusCode == 200) {
        // บันทึกข้อมูลสำเร็จ
        // อาจจะต้องทำการปรับปรุง UI หรือดำเนินการอื่นต่อไปที่เหมาะสม
        print('Data saved successfully');
      } else {
        // ไม่สามารถบันทึกข้อมูลได้
        print('Failed to save data.');
      }
    } catch (e) {
      // เกิดข้อผิดพลาดในการเชื่อมต่อกับเซิร์ฟเวอร์
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _usernameController.dispose();
    _telController.dispose();
    _provinceController.dispose();
    _typesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Edit Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: fetchData,
              child: Text('Fetch Data'),
            ),
            SizedBox(height: 20),
            Text('Message: $message'),
            if (userData != null) ...[
              TextFormField(
                controller: _firstnameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextFormField(
                controller: _lastnameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextFormField(
                controller: _telController,
                decoration: InputDecoration(labelText: 'Telephone'),
              ),
              TextFormField(
                controller: _provinceController,
                decoration: InputDecoration(labelText: 'Province'),
              ),
              TextFormField(
                controller: _typesController,
                decoration: InputDecoration(labelText: 'Types'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  saveData();
                },
                child: Text('Save'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: EditPage(),
  ));
}
