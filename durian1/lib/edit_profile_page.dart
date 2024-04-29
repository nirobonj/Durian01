import 'package:D1/home_page.dart';
import 'package:flutter/material.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 153),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 248, 153),
        title: const Text(
          'ข้อมูลส่วนตัว',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 350,
          height: 730,
          child: Card(
            child: ListView(
              children: const <Widget>[
                // ListTile(
                //   title: const Text(' แก้ไขข้อมูลส่วนตัว'),
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => HomePage()),
                //     );
                //   },
                // ),
                // const Divider(),
                // ListTile(
                //   title: const Text(' หน้าคำอธิบาย'),
                //   onTap: () {
                //     // ใส่โค้ดที่ต้องการให้ทำงานเมื่อคลิกที่รายการ Notifications ตรงนี้
                //   },
                // ),
                // const Divider(),
                // ListTile(
                //   title: const Text(
                //       ' Version                                                1.0'),
                //   onTap: () {
                //     // ใส่โค้ดที่ต้องการให้ทำงานเมื่อคลิกที่รายการ Privacy ตรงนี้
                //   },
                // ),

                // // เพิ่มรายการอื่นๆ ตามต้องการ
              ],
            ),
          ),
        ),
      ),
    );
  }
}
