import 'package:durian_sound/config.dart';
import 'package:flutter/material.dart';
import 'setting_page.dart';
import 'login_page.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'app_state.dart';

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
  FlutterSoundRecorder? _recorder;
  FlutterSoundPlayer? _player;
  bool _isRecording = false;

  late AppState _appState;
  late String _audioFilePath;
  late String recordingTimeStamp;
  late List<int> _recordedAudio;
  late List<int> _tempRecordedAudio;
  late String file_path;
  late String username;
  late String password;
  late String storeName;
  late Timer _timer;

  // @override
  // void initState() {
  //   super.initState();
  //   _tempRecordedAudio = [];
  // }
  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _player = FlutterSoundPlayer();
    recordingTimeStamp = '';
    _initAudioFilePath();
  }

  // Future<void> _initAudioFilePath() async {
  //   setState(() {
  //     // _audioFilePath = '${directory!.path}/Download/';
  //     _audioFilePath = '/storage/emulated/0/Download/';
  //   });
  // }
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
    Timer(const Duration(seconds: 3), () async {
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
      } else {
        if (kDebugMode) {
          print('File upload failed');
        }
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
    }
  }

  void _playRecording() async {
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

    try {
      await _player?.openPlayer();
      await _player?.startPlayer(
        fromURI: '$_audioFilePath$recordingTimeStamp.wav',
        codec: Codec.pcm16WAV,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error playing recording: $e');
      }
    }
  }

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
                      const SizedBox(height: 15),
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
                        onTap: _isRecording ? null : _startRecording,
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
                      backgroundColor: const Color.fromARGB(255, 255, 198, 54),
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
                const SizedBox(height: 50),
                Text(
                  'ชื่อไฟล์ : ${recordingTimeStamp ?? 'ไม่มีชื่อไฟล์'}',
                  style: const TextStyle(fontSize: 16),
                ),
                _isRecording
                    ? ElevatedButton(
                        onPressed: _stopRecording,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Stop Recording'),
                      )
                    : ElevatedButton(
                        onPressed: _startRecording,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Start Recording'),
                      ),
                !_isRecording
                    ? ElevatedButton(
                        onPressed: _playRecording,
                        child: const Text('Play Recording'),
                      )
                    : Container(),
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
