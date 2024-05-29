import 'dart:io';
import 'ad.dart';
import 'dart:async';
import 'dart:convert';
import 'setting_page.dart';
import 'package:get/get.dart';
import 'display_next_page.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:durian_sound/config.dart';
import 'package:durian_sound/login_page.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:durian_sound/ripple_animation.dart' as durian;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:url_launcher/url_launcher.dart';

class DisplayPage extends StatefulWidget {
  final bool isHomePageVisible;

  const DisplayPage({super.key, required this.isHomePageVisible});

  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool isPressed = false;
  FlutterSoundRecorder? _recorder;
  FlutterSoundPlayer? _player;
  bool _isRecording = false;

  late String _audioFilePath;
  late String recordingTimeStamp;
  late String username;
  late String password;
  late String storeName;
  late DateTime today;

  late AnimationController _controller;
  final FlutterSoundPlayer _audioPlayer = FlutterSoundPlayer();
  late Future<List<Ad>> futureAds;
  late Future<List<Ad>> adsFuture;
  Timer? _timer;
  int currentIndex = 0;
  final String defaultUsername = Get.find<UserController>().username.value;

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _player = FlutterSoundPlayer();
    recordingTimeStamp = '';
    _initAudioFilePath();
    adsFuture = fetchAds();
    today = DateTime.now();
  }

  Future<void> _initAudioFilePath() async {
    setState(() {
      Directory directory =
          Directory('/storage/emulated/0/Download/durian_sound/');
      if (directory.existsSync()) {
        if (kDebugMode) {
          print("Directory exists");
        }
      } else {
        if (kDebugMode) {
          print("Directory does not exist");
        }
        directory.createSync(recursive: true);
      }
      _audioFilePath = directory.path;
    });
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
  void dispose() {
    _controller.dispose();
    _recorder?.closeRecorder();
    _player?.closePlayer();
    _timer?.cancel();
    super.dispose();
  }

  void _startRecording() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      await Permission.microphone.request();
      status = await Permission.microphone.status;
      await Permission.storage.request();
      status = await Permission.storage.status;
      if (!status.isGranted) {
        if (kDebugMode) {
          print('ไม่ได้รับอนุญาตให้ใช้ไมค์');
          print('ไม่ได้รับอนุญาตให้เข้าถึงไฟล์เสียง');
        }
        return;
      }
    }
    await _initAudioFilePath();
    try {
      recordingTimeStamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      await _recorder?.openRecorder();
      await _recorder?.startRecorder(
        toFile: '$_audioFilePath$recordingTimeStamp.wav',
        codec: Codec.pcm16WAV,
      );
      setState(() {
        _isRecording = true;
      });
      _stopRecordingAfter7Seconds();
    } catch (e) {
      if (kDebugMode) {
        print('Error starting recording: $e');
      }
    }
  }

  void _stopRecordingAfter7Seconds() {
    Timer(const Duration(seconds: 7), () async {
      if (_isRecording) {
        _stopRecording();
      }
    });
  }

  void _stopRecording() async {
    try {
      await _recorder?.stopRecorder();
      setState(() {
        _isRecording = false;
      });
      playSound();
      String fileName = '$recordingTimeStamp' '.wav';
      if (kDebugMode) {
        print('Recording time stamp: $recordingTimeStamp');
        print(fileName);
      }
      String filePath = '$_audioFilePath$fileName';

      var url = Uri.parse('${AppConfig.connUrl}/sounds/predict/');
      var request = http.MultipartRequest('POST', url)
        ..files.add(http.MultipartFile.fromBytes(
            'audio', File(filePath).readAsBytesSync(),
            filename: fileName));

      var response = await request.send();
      if (response.statusCode == 200) {
        final data = await response.stream.transform(utf8.decoder).join();
        final jsonData = json.decode(data);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DisplayNextPage(
                    predict: jsonData['predictions'],
                  )),
        );
      } else {
        if (kDebugMode) {
          print('Request failed with status: ${response.statusCode}');
        }
      }

      var secondUrl =
          Uri.parse('http://203.154.158.79/duriansound-backend/uploadByuser');
      var secondRequest = http.MultipartRequest('POST', secondUrl)
        ..fields['username'] = defaultUsername
        ..files.add(http.MultipartFile.fromBytes(
            'audio', File(filePath).readAsBytesSync(),
            filename: fileName));

      var secondResponse = await secondRequest.send();
      if (secondResponse.statusCode == 200) {
        if (kDebugMode) {
          print('File uploaded successfully');
        }
        final data = await response.stream.transform(utf8.decoder).join();
        final jsonData = json.decode(data);
        print(jsonData);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DisplayNextPage(
                    predict: jsonData['predictions'],
                  )),
        );
      } else {
        if (kDebugMode) {
          print('File upload failed to second URL');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error stopping recording: $e');
      }
    }
  }

  Future<void> playSound() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
      status = await Permission.storage.status;
      if (!status.isGranted) {
        if (kDebugMode) {
          print('ไม่ได้รับอนุญาตให้เข้าถึงไฟล์เสียง');
        }
        return;
      }
    }
    String audioFilePath = 'assets/voice/voice.wav';
    try {
      ByteData bytes = await rootBundle.load(audioFilePath);
      Uint8List soundbytes = bytes.buffer.asUint8List();
      await _audioPlayer.openPlayer();
      await _audioPlayer.startPlayer(
        fromDataBuffer: soundbytes,
        codec: Codec.pcm16WAV,
      );
    } catch (e) {
      if (kDebugMode) {
        print('เกิดข้อผิดพลาดในการเล่นไฟล์เสียง: $e');
      }
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
                const SizedBox(height: 50),
                SizedBox(
                  width: 350,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 15),
                      _isRecording
                          ? SizedBox(
                              width: 200.0,
                              height: 200.0,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  durian.RippleAnimation(
                                    color:
                                        const Color.fromARGB(255, 255, 171, 54),
                                    delay: const Duration(milliseconds: 300),
                                    repeat: true,
                                    minRadius: 70,
                                    ripplesCount: 6,
                                    duration:
                                        const Duration(milliseconds: 10 * 300),
                                    child: GestureDetector(
                                      onTap:
                                          _isRecording ? null : _startRecording,
                                      child: const CircleAvatar(
                                        minRadius: 100,
                                        maxRadius: 100,
                                        backgroundColor:
                                            Color.fromARGB(255, 255, 250, 181),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      width: 200.0,
                                      height: 200.0,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child:
                                          Image.asset('assets/image/icon.PNG'),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: _isRecording ? null : _startRecording,
                              child: SizedBox(
                                width: 200.0,
                                height: 200.0,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        width: 200.0,
                                        height: 200.0,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(
                                            'assets/image/icon.PNG'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      const SizedBox(height: 50),
                      const Center(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              WidgetSpan(
                                child: SizedBox(width: 20),
                              ),
                              TextSpan(
                                text: 'กด',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              WidgetSpan(
                                child: SizedBox(width: 45),
                              ),
                              TextSpan(
                                text: '1',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              WidgetSpan(
                                child: SizedBox(width: 25),
                              ),
                              TextSpan(
                                text: 'ครั้ง\n',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              WidgetSpan(
                                child: SizedBox(width: 20),
                              ),
                              TextSpan(
                                text: 'เคาะ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              WidgetSpan(
                                child: SizedBox(width: 30),
                              ),
                              TextSpan(
                                text: '2',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              WidgetSpan(
                                child: SizedBox(width: 25),
                              ),
                              TextSpan(
                                text: 'ครั้ง\n',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              WidgetSpan(
                                child: SizedBox(width: 20),
                              ),
                              TextSpan(
                                text: 'ระยะ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              WidgetSpan(
                                child: SizedBox(width: 25),
                              ),
                              TextSpan(
                                text: '7',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              WidgetSpan(
                                child: SizedBox(width: 25),
                              ),
                              TextSpan(
                                text: 'เซนติเมตร\n',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
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
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 1;
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
        width: containerWidth,
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
