import 'ad.dart';
import 'dart:async';
import 'dart:convert';
import 'setting_page.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:durian_sound/config.dart';
import 'package:url_launcher/url_launcher.dart';

class DisplayNextPage extends StatefulWidget {
  final int predict;

  const DisplayNextPage({Key? key, required this.predict}) : super(key: key);

  @override
  _DisplayNextPageState createState() => _DisplayNextPageState();
}

class _DisplayNextPageState extends State<DisplayNextPage> {
  final ScrollController _scrollController = ScrollController();
  late Future<List<Ad>> futureAds;
  late Future<List<Ad>> adsFuture;
  Timer? _timer;
  int currentIndex = 0;
  late final int predict;
  late DateTime today;

  @override
  void initState() {
    super.initState();
    predict = widget.predict;
    adsFuture = fetchAds();
    today = DateTime.now();
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
    final response = await http.get(Uri.parse('${AppConfig.connUrl}/ad/ads/'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Ad> ads = data.map((json) => Ad.fromJson(json)).toList();

      return ads;
    } else {
      throw Exception('Failed to load ads');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 250, 181),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 250, 181),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingPage()),
            );
          },
        ),
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
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      // Container(
                      //   decoration: const BoxDecoration(
                      //     color: Color(0xffffea00),
                      //     borderRadius: BorderRadius.only(
                      //       topLeft: Radius.circular(10.0),
                      //       topRight: Radius.circular(10.0),
                      //     ),
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Align(
                      //       alignment: Alignment.center,
                      //       child: Text(
                      //         'ความสุกระดับ $predict',
                      //         style: const TextStyle(
                      //           fontWeight: FontWeight.bold,
                      //           fontSize: 25,
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      _buildRipenessWidget(predict),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
            List<Ad> ads = snapshot.data!;
            List<Ad> filteredAds = ads.where((ad) {
              DateTime adDate = DateTime.parse(ad.displayDuration);
              DateTime adDateOnly =
                  DateTime(adDate.year, adDate.month, adDate.day);
              DateTime todayOnly = DateTime(today.year, today.month, today.day);
              return adDateOnly.isAfter(todayOnly) ||
                  adDateOnly.isAtSameMomentAs(todayOnly);
            }).toList();

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

  Widget _buildRipenessWidget(int predict) {
    List<Widget> widgets = [];
    for (int i = predict; i <= 6 && i <= predict + 5; i++) {
      DateTime currentDate = (i == predict)
          ? today
          : today.add(Duration(hours: (i - predict) * 10));
      // print(currentDate);
      switch (i) {
        case 1:
          widgets.add(_buildLevelWidget(
            '1',
            'ดิบมาก \nยังรับประทานไม่ได้',
            'assets/image/ระดับ 1.png',
            currentDate,
          ));
          break;
        case 2:
          widgets.add(_buildLevelWidget(
            '2',
            'ดิบมาก \nยังรับประทานไม่ได้',
            'assets/image/ระดับ 2.png',
            currentDate,
          ));
          break;
        case 3:
          widgets.add(_buildLevelWidget(
            '3',
            'กึ่งสุกกึ่งดิบ \nกรอบนอก กรอบใน',
            'assets/image/ระดับ 3.png',
            currentDate,
          ));
          break;
        case 4:
          widgets.add(_buildLevelWidget(
            '4',
            'สุก เนื้อยอดนิยม \nนอกกรอบ ในนุ่ม',
            'assets/image/ระดับ 4.png',
            currentDate,
          ));
          break;
        case 5:
          widgets.add(_buildLevelWidget(
            '5',
            'สุกมาก สุกนุ่มกำลังดี\nเนื้อนิ่มเป็นครีมนุ่มนวล',
            'assets/image/ระดับ 5.png',
            currentDate,
          ));
          break;
        case 6:
          widgets.add(_buildLevelWidget(
            '6',
            'สุกมาก ๆ  \nเนื้อนิ่มจนเละ',
            'assets/image/ระดับ 6.png',
            currentDate,
          ));
          break;
        default:
          widgets.add(_buildLevelWidget(
            '0',
            'Unknown',
            'assets/image/ระดับ 0.png',
            currentDate,
          ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widgets,
      ),
    );
  }

  Widget _buildLevelWidget(
    String levelText,
    String detail,
    String imagePath,
    DateTime dateTime,
  ) {
    String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
    String formattedTime = DateFormat('HH:mm').format(dateTime);
    String formattedToday = DateFormat('dd MMMM yyyy').format(today);
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const SizedBox(height: 10),
      Container(
        width: 350,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (formattedDate == formattedToday)
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffffea00),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'ความสุกระดับ $predict',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            if (formattedDate != formattedToday)
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xffffea00),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'ความสุกระดับ $levelText',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 10),
            Text(
              '$detail\n',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
            Container(
              width: 250,
              height: 150,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 178, 178, 178),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: double.infinity,
                    height: 50,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        formattedDate,
                        style: const TextStyle(
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
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        formattedTime,
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 150,
              height: 150,
              color: const Color.fromARGB(255, 147, 147, 147),
              child: Image.asset(imagePath),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    ]);
  }
}
