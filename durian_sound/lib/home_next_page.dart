import 'package:durian_sound/display_page.dart';
import 'package:flutter/material.dart';

class HomeNextPage extends StatelessWidget {
  final bool isHomePageVisible;

  const HomeNextPage({super.key, required this.isHomePageVisible});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 153),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 248, 153),
        title: const Text(
          'วิธีการใช้งาน',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   width: 120,
            //   height: 120,
            //   child: Image.asset('assets/image/ระดับ 1.png'),
            // ),
            SizedBox(
                width: 200,
                height: 400,
                child: Container(
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: Image.asset('assets/image/how_to_use.jpg'),
                )),

            const SizedBox(height: 40),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DisplayPage(
                              isHomePageVisible: isHomePageVisible,
                            )),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffffea00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'เริ่มเข้าใช้งาน',
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
}
