import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:durian_sound/config.dart';
import 'package:durian_sound/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'Predict.dart';
import 'setting_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ad.dart';

class DisplayNextPage extends StatefulWidget {
  final int predict;

  const DisplayNextPage({super.key, required this.predict});

  @override
  _DisplayNextPageState createState() => _DisplayNextPageState();
}

class _DisplayNextPageState extends State<DisplayNextPage> {
  final ScrollController _scrollController = ScrollController();
  late Future<List<Ad>> futureAds;
  late Future<List<Ad>> adsFuture;
  Timer? _timer;
  int currentIndex = 0;
  final String defaultUsername = Get.find<UserController>().username.value;
  late final int predict;

  @override
  void initState() {
    super.initState();
    predict = widget.predict;
    adsFuture = fetchAds();
  }

  void _updateAds(List<Ad> ads) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: ads[currentIndex].transitionTime),
        (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % ads.length;
      });
    });
  }

  Future<List<Ad>> fetchAds() async {
    final response = await http.get(Uri.parse('${AppConfig.connUrl}/api/ads/'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Ad> ads = data.map((json) => Ad.fromJson(json)).toList();

      // Print all received ads
      // ads.forEach((ad) {
      //   print(
      //       'ImageUrl: ${ad.imageUrl}, \nLinkUrl: ${ad.linkUrl}, \nDisplayDuration: ${ad.displayDuration}, \nTransitionTime: ${ad.transitionTime}');
      // });

      return ads;
    } else {
      throw Exception('Failed to load ads');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(predict);
    }
    Predict result;
    switch (predict) {
      case 1:
        result = Predict(1, 'ดิบ 1', '1', '1', 'ดิบมากเนื้อสีครีม อ่อนๆ','assets/image/ระดับ 1.png');
        break;
      case 2:
        result = Predict(2, 'ดิบ2', '2', '2', 'ดิบรองลงมา สีเริ่มเหลืองนิดๆ','assets/image/ระดับ 2.png');
        break;
      case 3:
        result = Predict(3,'กึ่งสุกกึ่งดิบ','3','3','สีเหลืองมากกว่าดิบ2\nเนื้อกรอบๆ ใกล้จะสุก','assets/image/ระดับ 3.png');
        break;
      case 4:
        result = Predict(4,'สุก1','4','4','กรอบนอกนุ่มใน สีเหลืองมากขึ้น \nกรอบข้างนอกหน่อยๆ ข้างในนุ่มแล้ว','assets/image/ระดับ 4.png');
        break;
      case 5:
        result = Predict(5,'สุก2','5','5','สุกนุ่มกำลังดี\nเนื้อเป็นครีมมี่นุ่มนวล สีเหลืองสวย','assets/image/ระดับ 5.png');
        break;
      case 6:
        result = Predict(6,'สุก3','6','6','สุกมาก งอม \nนิยมนำไปทำทุเรียนกวน เพราะเนื้อค่อนข้างเละ','assets/image/ระดับ 6.png');
        break;
      default:
        result = Predict(0, 'ไม่ทราบระดับ', '0', '0', 'Unknown', 'assets/image/ระดับ 0.png');
    }

    print(
        'Level: ${result.level}, Title: ${result.title}, LevelText: ${result.levelText}, Detail: ${result.detail}, Image: ${result.image}');
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
                    height: 2050,
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
                                  Text(
                                    'ความสุกระดับที่ ${result.levelText} \n${result.title} \n${result.detail}\n',
                                    style: const TextStyle(
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
                                    child: Image.asset(result.image),
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
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
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
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
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
                                'ระดับความสุกของทุเรียนระดับถัดไป',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
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
      bottomNavigationBar: FutureBuilder<List<Ad>>(
        future: adsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: const Color.fromARGB(255, 255, 250, 181),
              height: 100,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Container(
              color: const Color.fromARGB(255, 255, 250, 181),
              height: 100,
              child: const Center(
                child: Text(
                  'Error loading ads',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            // List<Ad> ads = snapshot.data!;
            // List<Ad> filteredAds = ads.where((ad) {
            //   DateTime adDate = DateTime.parse(ad.displayDuration);
            //   DateTime today = DateTime.now();
            //   DateTime adDateOnly =
            //       DateTime(adDate.year, adDate.month, adDate.day);
            //   DateTime todayOnly = DateTime(today.year, today.month, today.day);
            //   return adDateOnly.isAfter(todayOnly) ||
            //       adDateOnly.isAtSameMomentAs(todayOnly);
            // }).toList();

            // filteredAds.forEach((ad) {
            //   print('ImageUrl: ${ad.imageUrl}, LinkUrl: ${ad.linkUrl}');
            // });
            List<Ad> ads = snapshot.data!;
            DateTime today = DateTime.now();
            List<Ad> filteredAds = ads.where((ad) {
              DateTime adDate = DateTime.parse(ad.displayDuration);
              DateTime adDateOnly =
                  DateTime(adDate.year, adDate.month, adDate.day);
              DateTime todayOnly = DateTime(today.year, today.month, today.day);
              return adDateOnly.isAfter(todayOnly) ||
                  adDateOnly.isAtSameMomentAs(todayOnly);
            }).toList();

            // filteredAds.forEach((ad) {
            //   print('\n\n\nImageUrl: ${ad.imageUrl},\n LinkUrl: ${ad.linkUrl},\n DisplayDuration: ${ad.displayDuration},');
            // });

            _updateAds(filteredAds);
            return Container(
              color: const Color.fromARGB(255, 255, 250, 181),
              height: 100,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildAdWidget(filteredAds, currentIndex),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              color: const Color.fromARGB(255, 255, 250, 181),
              height: 100,
              child: const Center(
                child: Text(
                  'No ads available',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildAdWidget(List<Ad> ads, int index) {
    return GestureDetector(
      onTap: () async {
        Uri uri = Uri.parse(ads[index].linkUrl);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        } else {
          throw 'Could not launch ${ads[index].linkUrl}';
        }
      },
      child: Container(
        width: 411,
        height: 100,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(ads[index].imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
