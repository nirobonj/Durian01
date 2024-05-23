import 'package:flutter/material.dart';
import 'display_page.dart';

class HomePage extends StatelessWidget {
  final bool isHomePageVisible;
  HomePage({super.key, required this.isHomePageVisible});
  final ScrollController _scrollController = ScrollController();

  void next(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DisplayPage(
                isHomePageVisible: isHomePageVisible,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 250, 181),
      body: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const Text(
                  'คำอธิบาย',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: 350,
                  height: 2020,
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
                                  fontSize: 25,
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
                                    'ระดับที่ 1 : ดิบมาก \nยังรับประทานไม่ได้',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 40),
                                  SizedBox(
                                    width: 120,
                                    height: 120,
                                    child:
                                        Image.asset('assets/image/ระดับ 1.png'),
                                  ),
                                  const SizedBox(height: 40),
                                  const Divider(),
                                  const SizedBox(height: 40),
                                  const Text(
                                    'ระดับที่ 2 : ดิบมาก \nยังรับประทานไม่ได้',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 40),
                                  SizedBox(
                                    width: 120,
                                    height: 120,
                                    child:
                                        Image.asset('assets/image/ระดับ 2.png'),
                                  ),
                                  const SizedBox(height: 40),
                                  const Divider(),
                                  const SizedBox(height: 40),
                                  const Text(
                                    'ระดับที่ 3 : กึ่งสุกกึ่งดิบ \nกรอบนอก กรอบใน \nเนื้อเป็นเส้น เหมือนเนื้อไก่ฉีก \nกลิ่นอ่อน ๆ หวานมัน',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 40),
                                  SizedBox(
                                    width: 120,
                                    height: 120,
                                    child:
                                        Image.asset('assets/image/ระดับ 3.png'),
                                  ),
                                  const SizedBox(height: 40),
                                  const Divider(),
                                  const SizedBox(height: 40),
                                  const Text(
                                    'ระดับที่ 4 : สุก \nเนื้อยอดนิยม \nนอกกรอบ ในนุ่ม \nหอมกำลังดี',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 40),
                                  SizedBox(
                                    width: 120,
                                    height: 120,
                                    child:
                                        Image.asset('assets/image/ระดับ 4.png'),
                                  ),
                                  const SizedBox(height: 40),
                                  const Divider(),
                                  const SizedBox(height: 40),
                                  const Text(
                                    'ระดับที่ 5 : สุกมาก สุกนุ่มกำลังดี\nเนื้อนิ่มเป็นครีมนุ่มนวล \nหวานฉ่ำ กลิ่นแรง',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 40),
                                  SizedBox(
                                    width: 120,
                                    height: 120,
                                    child:
                                        Image.asset('assets/image/ระดับ 5.png'),
                                  ),
                                  const SizedBox(height: 40),
                                  const Divider(),
                                  const SizedBox(height: 40),
                                  const Text(
                                    'ระดับที่ 6 : สุกมาก ๆ  \nเนื้อนิ่มจนเละ \nรสขมเล็กน้อย ปลายลิ้น \nกลิ่นแรงมาก',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 40),
                                  SizedBox(
                                    width: 120,
                                    height: 120,
                                    child:
                                        Image.asset('assets/image/ระดับ 6.png'),
                                  ),
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
      ),
    );
  }
}
