import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 250, 181),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 250, 181),
        title: const Text(
          'เกี่ยวกับเรา',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 320,
          height: 1000,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // จัดกึ่งกลางแนวนอน
            crossAxisAlignment: CrossAxisAlignment.start, // จัดให้อยู่ทางขวา
            children: [
              // Text(
              //   'About Us',
              //   style: TextStyle(
              //     fontSize: 25,
              //     fontWeight: FontWeight.bold,
              //   ),
              //   textAlign: TextAlign.left,
              // ),
              const SizedBox(height: 20),
              SizedBox(
                width: 150,
                height: 50,
                child: Image.asset('assets/image/DoubleMM.png'),
              ),
              const SizedBox(height: 10),
              const Text(
                'Develop by Double M Technology Management Co.ltd \nwww.doublemtech.com',
                style: TextStyle(
                  fontSize: 13,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 10),
              const Text(
                '© copyright 2024',
                style: TextStyle(
                  fontSize: 12,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
