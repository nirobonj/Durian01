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
              // mainAxisAlignment: MainAxisAlignment.center,
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
                  height: 2140,
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
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 40),
                              const SizedBox(
                                height: 50,
                                width: 350,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 50),
                                    child: Text(
                                      'ระดับที่ 1 : ดิบมาก (over raw)\n- ยังรับประทานไม่ได้',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),
                              SizedBox(
                                width: 120,
                                height: 120,
                                child: Image.asset('assets/image/ระดับ 1.png'),
                              ),
                              const SizedBox(height: 40),
                              const Divider(),
                              const SizedBox(height: 40),
                              const SizedBox(
                                height: 50,
                                width: 350,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 50),
                                    child: Text(
                                      'ระดับที่ 2 : ดิบมาก (raw)\n- ยังรับประทานไม่ได้',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),
                              SizedBox(
                                width: 120,
                                height: 120,
                                child: Image.asset('assets/image/ระดับ 2.png'),
                              ),
                              const SizedBox(height: 40),
                              const Divider(),
                              const SizedBox(height: 40),
                              const SizedBox(
                                height: 110,
                                width: 350,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 50),
                                    child: Text(
                                      'ระดับที่ 3 : กึ่งสุกกึ่งดิบ (unripe)\n- กรอบนอก กรอบใน \n- เนื้อเป็นเส้น เหมือนเนื้อไก่ฉีก \n- กลิ่นอ่อน ๆ หวานมัน',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),
                              SizedBox(
                                width: 120,
                                height: 120,
                                child: Image.asset('assets/image/ระดับ 3.png'),
                              ),
                              const SizedBox(height: 40),
                              const Divider(),
                              const SizedBox(height: 40),
                              const SizedBox(
                                height: 110,
                                width: 350,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 50),
                                    child: Text(
                                      'ระดับที่ 4 : สุก (ripe)\n- เนื้อยอดนิยม \n- กรอบนอก นุ่มใน \n- หอมกำลังดี',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),
                              SizedBox(
                                width: 120,
                                height: 120,
                                child: Image.asset('assets/image/ระดับ 4.png'),
                              ),
                              const SizedBox(height: 40),
                              const Divider(),
                              const SizedBox(height: 40),
                              const SizedBox(
                                height: 105,
                                width: 350,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 50),
                                    child: Text(
                                      'ระดับที่ 5 : สุกมาก (creamy)\n- สุกกำลังดี \n- เนื้อนิ่มเป็นครีมนุ่มนวล \n- หวานฉ่ำ กลิ่นแรง',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),
                              SizedBox(
                                width: 120,
                                height: 120,
                                child: Image.asset('assets/image/ระดับ 5.png'),
                              ),
                              const SizedBox(height: 40),
                              const Divider(),
                              const SizedBox(height: 40),
                              const SizedBox(
                                height: 110,
                                width: 350,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 50),
                                    child: Text(
                                      'ระดับที่ 6 : สุกมาก ๆ (over ripe)\n- เนื้อนิ่มจนเละ \n- รสขมเล็กน้อย ปลายลิ้น \n- กลิ่นแรงมาก',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),
                              SizedBox(
                                width: 120,
                                height: 120,
                                child: Image.asset('assets/image/ระดับ 6.png'),
                              ),
                              const SizedBox(height: 40),
                            ],
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
