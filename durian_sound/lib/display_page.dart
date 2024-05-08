import 'package:flutter/material.dart';
import 'setting_page.dart';
import 'login_page.dart';

class DisplayPage extends StatefulWidget {
  final bool isHomePageVisible;

  DisplayPage({Key? key, required this.isHomePageVisible}) : super(key: key);

  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  final ScrollController _scrollController = ScrollController();
  static const IconData settings =
      IconData(0xe57f, fontFamily: 'MaterialIcons');
  bool _isExpanded = false;
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 248, 153),
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
                const SizedBox(height: 100),
                SizedBox(
                  width: 350,
                  height: 5000,
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      //
                      // GestureDetector(
                      //   onTapDown: (TapDownDetails details) {
                      //     setState(() {
                      //       isPressed = true;
                      //     });
                      //   },
                      //   onTapUp: (TapUpDetails details) {
                      //     setState(() {
                      //       isPressed = false;
                      //     });
                      //   },
                      //   child: AnimatedContainer(
                      //     duration: Duration(milliseconds: 200),
                      //     width: 200.0,
                      //     height: 200.0,
                      //     decoration: BoxDecoration(
                      //       color: Color.fromARGB(255, 255, 223, 61),
                      //       shape: BoxShape.circle,
                      //       boxShadow: isPressed
                      //           ? [
                      //               BoxShadow(
                      //                 color:
                      //                     Color.fromARGB(255, 255, 180, 5)
                      //                         .withOpacity(0.2),
                      //                 blurRadius: 400.0,
                      //                 spreadRadius: 100.0,
                      //                 offset: const Offset(
                      //                   0.0,
                      //                   3.0,
                      //                 ),
                      //               ),
                      //             ]
                      //           : [],
                      //     ),
                      //     child: Center(
                      //       child: AnimatedContainer(
                      //         duration: const Duration(milliseconds: 200),
                      //         width: 170.0,
                      //         height: 170.0,
                      //         decoration: const BoxDecoration(
                      //           color: Color.fromARGB(255, 255, 174, 61),
                      //           shape: BoxShape.circle,
                      //         ),
                      //       ),
                      //     ),

                      //   ),
                      // ),
                      GestureDetector(
                        onTapDown: (TapDownDetails details) {
                          setState(() {
                            isPressed = true;
                          });
                        },
                        onTapUp: (TapUpDetails details) {
                          setState(() {
                            isPressed = false;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 200.0,
                          height: 200.0,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 223, 61),
                            shape: BoxShape.circle,
                            boxShadow: isPressed
                                ? [
                                    BoxShadow(
                                      color:
                                          const Color.fromARGB(255, 255, 180, 5)
                                              .withOpacity(0.2),
                                      blurRadius: 200.0,
                                      spreadRadius: 100.0,
                                      offset: const Offset(
                                        0.0,
                                        3.0,
                                      ),
                                    ),
                                  ]
                                : [],
                          ),
                          child: Center(
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 15,
                                  left: 15,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    width: 170.0,
                                    height: 170.0,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 255, 171, 54),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 20,
                                  left: 20,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    width: 160.0,
                                    height: 160.0,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 255, 106, 13),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                // Positioned(
                                //   top: 80,
                                //   left: 80,
                                //   child: AnimatedContainer(
                                //     duration: const Duration(milliseconds: 200),
                                //     width: 40.0,
                                //     height: 40.0,
                                //     decoration: BoxDecoration(
                                //       color: Color.fromARGB(255, 255, 174, 61),
                                //       shape: BoxShape.circle,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Text('isHomePageVisible: ${widget.isHomePageVisible}'),
                      const SizedBox(height: 50),
                      const Text(
                        'กรุณาเคาะอย่างน้อย 2 ครั้ง',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18, // กำหนดสีข้อความใน Body
                        ),
                      ),
                      const Text(
                        'กรุณาเคาะไม่เกินระยะ __ เซนติเมตร',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18, // กำหนดสีข้อความใน Body
                        ),
                      ),
                    ],
                  ),
                ),
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
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 198, 54), // background color
                    ),
                    child: const Text('เคาะอีกครั้ง',style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold, // กำหนดสีข้อความใน Body
                        ),),
                  ),
                ),
                 const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),

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