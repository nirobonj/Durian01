import 'package:durian_sound/edit_form_page.dart'; // นำเข้าไฟล์ edit_form_page.dart
import 'package:durian_sound/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPage extends StatelessWidget {
  final String defaultUsername = Get.find<UserController>().username.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 250, 181),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 250, 181),
        title: const Text(
          'ข้อมูลส่วนตัว',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    EditFormPage(defaultUsername: defaultUsername),
              ),
            );
          },
          child: const Text('แก้ไขข้อมูล'),
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
