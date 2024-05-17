import 'dart:io';
import 'dart:async';
import 'package:durian_sound/config.dart';

import 'setting_page.dart';
import 'display_next_page.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:durian_sound/ripple_animation.dart' as durian;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart' show rootBundle;

class DisplayPage extends StatefulWidget {
  final bool isHomePageVisible;

  const DisplayPage({super.key, required this.isHomePageVisible});

  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  final ScrollController _scrollController = ScrollController();
  bool isPressed = false;
  FlutterSoundRecorder? _recorder;
  FlutterSoundPlayer? _player;
  bool _isRecording = false;

  late String _audioFilePath;
  late String recordingTimeStamp;
  late String file_path;
  late String username;
  late String password;
  late String storeName;

  late AnimationController _controller;
  FlutterSoundPlayer _audioPlayer = FlutterSoundPlayer();

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _player = FlutterSoundPlayer();
    recordingTimeStamp = '';
    _initAudioFilePath();
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

  @override
  void dispose() {
    _controller.dispose();
    _recorder?.closeRecorder();
    _player?.closePlayer();
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
        recordingTimeStamp =
            DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      });
      _stopRecordingAfter20Seconds();
    } catch (e) {
      if (kDebugMode) {
        print('Error starting recording: $e');
      }
    }
  }

  void _stopRecordingAfter20Seconds() {
    Timer(const Duration(seconds: 10), () async {
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
      if (kDebugMode) {
        print('Recording time stamp: $recordingTimeStamp');
      }
      String fileName = '$recordingTimeStamp' '.wav';

      if (kDebugMode) {
        print(fileName);
      }
      String filePath = '$_audioFilePath$fileName';
      // predict URL
      var url = Uri.parse('${AppConfig.connUrl}/sounds/upload_file/');
      var request = http.MultipartRequest('POST', url)
        ..files.add(http.MultipartFile.fromBytes(
            'audio', File(filePath).readAsBytesSync(),
            filename: fileName));

      var response = await request.send();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('File uploaded successfully');
        }
        // Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => DisplayNextPage()),
        //     );
      } else {
        if (kDebugMode) {
          print('File upload failed');
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DisplayNextPage()),
        );
      }
      // Upload to second URL
      var secondUrl = Uri.parse(
          'https://zbx5wgnt-4300.asse.devtunnels.ms/duriansound-backend/uploadByuser');
      var secondRequest = http.MultipartRequest('POST', secondUrl)
        ..files.add(http.MultipartFile.fromBytes(
            'audio', File(filePath).readAsBytesSync(),
            filename: fileName));

      var secondResponse = await secondRequest.send();
      if (secondResponse.statusCode == 200) {
        if (kDebugMode) {
          print('File uploaded successfully to second URL');
        }
      } else {
        if (kDebugMode) {
          print('File upload failed to second URL');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error stopping recording: $e');
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DisplayNextPage()),
      );
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

    String audioFilePath = 'assets/image/voice.wav';
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
                  // height: 500,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 15),
                      _isRecording
                          ? SizedBox(
                              width: 200.0,
                              height: 200.0,
                              child: Stack(
                                alignment: Alignment
                                    .center, // Align all children in the center
                                children: [
                                  Positioned(
                                    top: 10,
                                    left: 10,
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      width: 180.0,
                                      height: 180.0,
                                      decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 220, 63),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 25,
                                    left: 25,
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      width: 150.0,
                                      height: 150.0,
                                      decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 171, 54),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  durian.RippleAnimation(
                                    color: const Color.fromARGB(255, 255, 106, 13),
                                    delay: const Duration(milliseconds: 300),
                                    repeat: true,
                                    minRadius: 70,
                                    ripplesCount: 6,
                                    duration: const Duration(milliseconds: 10 * 300),
                                    child: GestureDetector(
                                      onTap:
                                          _isRecording ? null : _startRecording,
                                      child: const CircleAvatar(
                                        minRadius: 70,
                                        maxRadius: 70,
                                        backgroundColor:
                                            Color.fromARGB(255, 255, 106, 13),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: _isRecording ? null : _startRecording,
                              child: SizedBox(
                                width: 200.0,
                                height: 200.0,
                                child: Stack(
                                  alignment: Alignment
                                      .center, // Align all children in the center
                                  children: [
                                    Positioned(
                                      top: 10,
                                      left: 10,
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        width: 180.0,
                                        height: 180.0,
                                        decoration: const BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 255, 220, 63),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 25,
                                      left: 25,
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        width: 150.0,
                                        height: 150.0,
                                        decoration: const BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 255, 171, 54),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 30,
                                      left: 30,
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        width: 140.0,
                                        height: 140.0,
                                        decoration: const BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 255, 106, 13),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ],
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
                const SizedBox(height: 50),
                const SizedBox(height: 50),
                Text(
                  'ชื่อไฟล์ : $recordingTimeStamp',
                  style: const TextStyle(fontSize: 16),
                ),
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
