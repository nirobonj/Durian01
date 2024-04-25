import 'package:flutter/material.dart';
import 'display_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  void next(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DisplayPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 153),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 70),
              const Text(
                'คำอธิบาย',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: 350,
                height: 2000,
                child: Card(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xffffea00),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'ระดับความสุกของทุเรียน',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // const Divider(),
                      // Container(
                      //   height: 2, // ปรับความหนาของ Divider ตรงนี้
                      //   color: Colors.grey, // สีของเส้นแบ่ง
                      // ),

                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Body',
                              style: TextStyle(
                                color: Colors.black, // กำหนดสีข้อความใน Body
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: 220,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => next(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffffea00),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'ปิด',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}



/*import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        // appBar: AppBar(
        //   title: const Text('Home Page'),
        // ),
        backgroundColor: Color.fromARGB(255, 255, 248, 153),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'คำอธิบาย',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 25),
            SizedBox(
              width: 200,
              height: 200,
              child: Card(
                color: Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  // ใช้ Column เพื่อเรียง Header และ Body แนวตั้ง
                  children: [
                    // Header
                    Padding(
                      child: Color(0xffffea00),
                      padding: EdgeInsets.all(8.0),
                      children: [
                        Text(
                          'Header',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            
                          ),
                        ),
                      ],
                    ),
                    Divider(), // เพิ่มเส้นขั้นระหว่าง Header กับ Body
                    // Body
                    Expanded(
                      child: Center(
                        child: Text(
                          'Body',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ), //Center
              ),
            ),
          ]),
        ));
  }
}*/
