import 'package:flutter/material.dart';
import 'display_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key});
  final ScrollController _scrollController = ScrollController();

  void next(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DisplayPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 153),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        backgroundColor: const Color(0xffffea00),
        child: const Icon(Icons.arrow_downward),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
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
                height: 3000,
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
                          child: Center(
                            child: Column(
                              children: [
                                const Text(
                                  'ระดับที่ 1 : ดิบ1  (0%)',
                                  style: TextStyle(
                                    color:
                                        Colors.black, // กำหนดสีข้อความใน Body
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/lv1.png',
                                  width: 100, // กำหนดความกว้างเป็น 100 pixels
                                  height: 100, // กำหนดความสูงเป็น 100 pixels),
                                )
                              ],
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
