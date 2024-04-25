import 'package:flutter/material.dart';
import 'edit_profile_page.dart';
class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('การตั้งค่า'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('แก้ไขข้อมูลส่วนตัว'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditPage()),
                );
            },
          ),
          ListTile(
            title: const Text('หน้าคำอธิบาย'),
            onTap: () {
              // ใส่โค้ดที่ต้องการให้ทำงานเมื่อคลิกที่รายการ Notifications ตรงนี้
            },
          ),
          ListTile(
            title: const Text('Version                                                  1.0'),
            onTap: () {
              // ใส่โค้ดที่ต้องการให้ทำงานเมื่อคลิกที่รายการ Privacy ตรงนี้
            },
          ),
          // เพิ่มรายการอื่นๆ ตามต้องการ
        ],
      ),
    );
  }
}
