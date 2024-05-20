import 'package:flutter/material.dart';
import 'setting_page.dart';

class DisplayNextPage extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  DisplayNextPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 250, 181),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 250, 181),
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingPage()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.settings, size: 40),
            ),
          ),
        ],
      ),
      body: Scrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 350,
                    height: 650,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              _scrollController.animateTo(
                                0.0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 198, 54),
                            ),
                            child: const Text(
                              'เคาะอีกครั้ง',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
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
                                'ระดับความสุกของทุเรียน : ปัจจุบัน',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
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
                                  const SizedBox(height: 40),
                                  const Text(
                                    'ระดับที่ 1 : ดิบ1 (0%)',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    width: 200,
                                    height: 200,
                                    color: const Color.fromARGB(
                                        255, 147, 147, 147),
                                    // child: Image.asset('assets/lv1.png'),
                                  ),
                                  const SizedBox(height: 30),
                                  Container(
                                    width: 250,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 178, 178, 178),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 50,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 2.0),
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'DD MM YYYY', 
                                              style: TextStyle(
                                                fontSize: 25, 
                                                color: Colors
                                                    .black, 
                                                fontWeight: FontWeight
                                                    .bold, 
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 50,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 2.0),
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'Text 1', 
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors
                                                    .black, 
                                                fontWeight: FontWeight
                                                    .bold, 
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
      bottomNavigationBar: Container(
        color: Colors.grey,
        height: 100,
        child: const Center(
          child: Text(
            'Your advertisement content here',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
