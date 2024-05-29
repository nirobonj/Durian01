import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:durian_sound/config.dart';
import 'package:durian_sound/setting_page.dart';

class EditFormPage extends StatefulWidget {
  final String defaultUsername;
  const EditFormPage({required this.defaultUsername, super.key});

  @override
  _EditFormPageState createState() => _EditFormPageState();
}

class _EditFormPageState extends State<EditFormPage> {
  String message = '';
  Map<String, dynamic>? userData;
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _telController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _typesController = TextEditingController();
  final TextEditingController _aumphurController = TextEditingController();
  final TextEditingController _tumbolController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse(
          'https://cb5dhsk3-8000.asse.devtunnels.ms/duriansound-analyisis/users/edit/${widget.defaultUsername}'),
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        message = responseData['message'] ?? '';
        userData = responseData['data'];
        _firstnameController.text = userData?['firstname'] ?? '';
        _lastnameController.text = userData?['lastname'] ?? '';
        _usernameController.text = userData?['username'] ?? '';
        _telController.text = userData?['tel'] ?? '';
        _provinceController.text = userData?['province'] ?? '';
        _typesController.text = userData?['types'] ?? '';
        _aumphurController.text = userData?['pro_aumphur_desc'] ?? '';
        _tumbolController.text = userData?['pro_tumbol_desc'] ?? '';

      });
    } else {
      if (kDebugMode) {
        print('Failed to fetch data.');
      }
    }
  }

  // Future<List<String>> fetchProvinces() async {
  //   final response = await http.get(Uri.parse('${AppConfig.connUrl}/duriansound-analyisis/users/pro-mstr/'));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = json.decode(response.body);
  //     return data.map((province) => province['name'] as String).toList();
  //   } else {
  //     throw Exception('Failed to load provinces');
  //   }
  // }
  Future<List<String>> fetchProvinces() async {
    final response = await http.get(Uri.parse(
        'https://cb5dhsk3-8000.asse.devtunnels.ms/duriansound-analyisis/users/pro-mstr/'));
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body, reviver: (key, value) {
        if (value is String) {
          return utf8.decode(value.runes.toList());
        }
        return value;
      });

      if (data is Map<String, dynamic> &&
          data.containsKey('province_descs') &&
          data['province_descs'] is List<dynamic>) {
        // ตรวจสอบว่ามี key 'province_descs' และเป็น List<dynamic> หรือไม่
        final provinces = data['province_descs'] as List<dynamic>;
        return provinces.map((province) => province as String).toList();
      } else {
        throw Exception('Invalid data format');
      }
    } else {
      throw Exception('Failed to load provinces');
    }
  }

  // Future<void> saveData() async {
  //   final url = Uri.parse(
  //       '${AppConfig.connUrl}/duriansound-analyisis/users/edit/${widget.defaultUsername}');
  //   try {
  //     final response = await http.put(
  //       url,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, String>{
  //         'firstname': _firstnameController.text,
  //         'lastname': _lastnameController.text,
  //         'tel': _telController.text,
  //         'province': _provinceController.text,
  //         'types': _typesController.text,
  //         'pro_aumphur_desc': _aumphurController.text,
  //         'pro_tumbol_desc': _tumbolController.text,
          
  //       }),
  //     );

  //     if (response.statusCode == 200) {
  //       showSuccessDialog();
  //     } else {
  //       if (kDebugMode) {
  //         print('Failed to save data.');
  //       }
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Error: $e');
  //     }
  //   }
  // }

  Future<List<String>> fetchAumphurs(String province) async {
    Uri uri = Uri.parse(
            'https://cb5dhsk3-8000.asse.devtunnels.ms/duriansound-analyisis/users/pro-mstr/aumphur')
        .replace(queryParameters: {'pro_province_desc': province});
    String url = uri.toString();

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final dynamic responseData = json.decode(response.body);

      // ตรวจสอบให้แน่ใจว่า responseData เป็น Map และมีโครงสร้างที่ถูกต้อง
      if (responseData is Map<String, dynamic> &&
          responseData['status'] == 'success') {
        final List<dynamic> data = responseData['data'];
        if (data is List<dynamic>) {
          // List<String> aumphurs = data.map((item) => item as String).toList();
          List<String> aumphurs =
              data.map((item) => utf8.decode(item.codeUnits)).toList();
          // print('this is aumphurs: $aumphurs');
          // print(aumphurs);
          return aumphurs;
        } else {
          // print('$responseData');
          throw Exception('รูปแบบข้อมูลไม่ถูกต้อง: $responseData');
        }
      } else {
        // print('$responseData');
        throw Exception('รูปแบบข้อมูลไม่ถูกต้อง: $responseData');
      }
    } else {
      throw Exception('โหลดข้อมูลอำเภอไม่สำเร็จ');
    }
  }

  Future<List<String>> fetchTumbols(String aumphur) async {
    Uri uri = Uri.parse(
            'https://cb5dhsk3-8000.asse.devtunnels.ms/duriansound-analyisis/users/pro-mstr/tumbol')
        .replace(queryParameters: {'pro_aumphur_desc': aumphur});
    String url = uri.toString();

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // final dynamic responseData = json.decode(response.body);
      final dynamic responseData = json.decode(utf8.decode(response.bodyBytes));

      if (responseData is Map<String, dynamic> &&
          responseData['status'] == 'success') {
        final List<dynamic> data = responseData['data'];

        if (data is List<dynamic>) {
          // แปลงข้อมูลใน list ให้เป็น list ของ String
          List<String> tumbols = data
              .expand((item) => (item['pro_tumbol_desc'] as String).split(","))
              .map((tumbol) => tumbol.trim())
              .toList();

          // print(tumbols);
          // print('this is tumbol: $tumbols');
          return tumbols;
        } else {
          print('$responseData');
          throw Exception('รูปแบบข้อมูลไม่ถูกต้อง: $responseData');
        }
      } else {
        // print('$responseData');
        throw Exception('รูปแบบข้อมูลไม่ถูกต้อง: $responseData');
      }
    } else {
      throw Exception('โหลดข้อมูลตำบลไม่สำเร็จ');
    }
  }
Future<void> saveData() async {
    final url = Uri.parse(
        'https://cb5dhsk3-8000.asse.devtunnels.ms/duriansound-analyisis/users/edit/${widget.defaultUsername}');
    try {
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'firstname': _firstnameController.text,
          'lastname': _lastnameController.text,
          'tel': _telController.text,
          'province': _provinceController.text,
          'types': _typesController.text,
          'pro_aumphur_desc': _aumphurController.text,
          'pro_tumbol_desc': _tumbolController.text,
          
        }),
        
      );
      print("_aumphurController savedata: ${_aumphurController.text}");
      print("_tumbolController savedata: ${_tumbolController.text}");

    
      if (response.statusCode == 200) {
        showSuccessDialog();
      } else {
        if (kDebugMode) {
          print('Failed to save data.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }
  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('สำเร็จ'),
          content: const Text('บันทึกข้อมูลสำเร็จ'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingPage()),
                );
              },
              child: const Text('ตกลง'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _usernameController.dispose();
    _telController.dispose();
    _provinceController.dispose();
    _typesController.dispose();
    _aumphurController.dispose();
    _tumbolController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 248, 153),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 248, 153),
        title: const Text(
          'ข้อมูลส่วนตัว',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: userData == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 270,
                    height: 50,
                    child: TextFormField(
                      controller: _usernameController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: 'กรอกชื่อผู้ใช้',
                        labelText: 'ชื่อผู้ใช้',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 218, 218, 218),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 270,
                    height: 50,
                    child: TextFormField(
                      controller: _firstnameController,
                      decoration: InputDecoration(
                        hintText: 'กรอกชื่อ',
                        labelText: 'ชื่อ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 270,
                    height: 50,
                    child: TextFormField(
                      controller: _lastnameController,
                      decoration: InputDecoration(
                        hintText: 'กรอกนามสกุล',
                        labelText: 'นามสกุล',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 270,
                    height: 50,
                    child: TextFormField(
                      controller: _telController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: InputDecoration(
                        hintText: 'กรอกเบอร์โทรศัพท์',
                        labelText: 'เบอร์โทรศัพท์',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 270,
                    height: 65,
                    child: FutureBuilder<List<String>>(
                      future: fetchProvinces(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return DropdownButtonFormField<String>(
                            value: _provinceController.text,
                            onChanged: (String? value) {
                              setState(() {
                                _provinceController.text = value!;
                                fetchAumphurs(
                                    value!); // เรียกใช้เมท็อด fetchAumphurs เมื่อมีการเปลี่ยนแปลงค่าจังหวัด
                              });
                            },
                            items: snapshot.data!
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            hint: const Text('เลือกจังหวัด'),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              fillColor: Colors.white,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        return CircularProgressIndicator(); // แสดง CircularProgressIndicator ในระหว่างโหลดข้อมูล
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 270,
                    height: 65,
                    child: FutureBuilder<List<String>>(
                      future: fetchAumphurs(_provinceController.text),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Text('ไม่มีข้อมูล');
                        } else {
                          // ตรวจสอบให้แน่ใจว่าค่าเริ่มต้นอยู่ในรายการ
                          if (!_aumphurController.text.isEmpty &&
                              !snapshot.data!
                                  .contains(_aumphurController.text)) {
                            _aumphurController.text =
                                ''; // หรือค่าเริ่มต้นที่ต้องการ
                            // print(_aumphurController);
                          }

                          return DropdownButtonFormField<String>(
                            value: _aumphurController.text.isEmpty
                                ? null
                                : _aumphurController.text,
                            onChanged: (String? value) {
                              setState(() {
                                _aumphurController.text = value!;
                                fetchTumbols(_aumphurController.text);
                                
                                print("VALUE: $value");
                                print(
                                    "_aumphurController: ${_aumphurController.text}");
                              });
                             
                            },
                            items: snapshot.data!
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                ),
                              );
                            }).toList(),
                            hint: const Text('เลือกอำเภอ'),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              fillColor: Colors.white,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 270,
                    height: 65,
                    child: FutureBuilder<List<String>>(
                      future: fetchTumbols(_aumphurController.text),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          print('เกิดข้อผิดพลาด: ${snapshot.error}');
                          return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Text('ไม่มีข้อมูล');
                        } else {
                          // ตรวจสอบให้แน่ใจว่าค่าเริ่มต้นอยู่ในรายการ
                          print('tumbols: ${snapshot.data}');
                          if (!_tumbolController.text.isEmpty &&
                              !snapshot.data!
                                  .contains(_tumbolController.text)) {
                            _tumbolController.text =
                                ''; // หรือค่าเริ่มต้นที่ต้องการ
                            print(
                                "_tumbolController: ${_tumbolController.text}");
                            print(snapshot.data.runtimeType);
                          }

                          return DropdownButtonFormField<String>(
                            value: _tumbolController.text.isNotEmpty &&
                                    snapshot.data!
                                        .contains(_tumbolController.text)
                                ? _tumbolController.text
                                : null,
                            onChanged: (String? value) {
                              setState(() {
                                _tumbolController.text = value!;
                              });
                            },
                            items: snapshot.data!
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            hint: const Text('เลือกตำบล'),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              fillColor: Colors.white,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  
                  // const SizedBox(height: 10),
                  // SizedBox(
                  //   width: 220,
                  //   height: 65,
                  //   child: DropdownButtonFormField<String>(
                  //     value: _provinceController.text,
                  //     onChanged: (String? value) {
                  //       setState(() {
                  //         _provinceController.text = value!;
                  //       });
                  //     },
                  //     items: <String>[
                  //     'กรุงเทพมหานคร','กระบี่','กาญจนบุรี','ปทุมธานี','กาฬสินธุ์','กำแพงเพชร',
                  //     'ขอนแก่น','จันทบุรี','ฉะเชิงเทรา','ชลบุรี','ชัยนาท','ชัยภูมิ','ชุมพร','เชียงราย',
                  //     'เชียงใหม่','ตรัง','ตราด','ตาก','นครนายก','นครปฐม','นครพนม','นครราชสีมา',
                  //     'นครศรีธรรมราช','นครสวรรค์','นนทบุรี','นราธิวาส','น่าน','บึงกาฬ','บุรีรัมย์',
                  //     'ปทุมธานี','ประจวบคีรีขันธ์','ปราจีนบุรี','ปัตตานี','พังงา','พัทลุง','พิจิตร',
                  //     'พิษณุโลก','เพชรบุรี','เพชรบูรณ์','แพร่','พะเยา','ภูเก็ต','มหาสารคาม',
                  //     'มุกดาหาร','แม่ฮ่องสอน','ยะลา','ยโสธร','ร้อยเอ็ด','ระนอง','ระยอง','ราชบุรี',
                  //     'ลพบุรี','ลำปาง','ลำพูน','เลย','ศรีสะเกษ','สกลนคร','สงขลา','สตูล',
                  //     'สมุทรปราการ','สมุทรสงคราม','สมุทรสาคร','สระแก้ว','สระบุรี','สิงห์บุรี',
                  //     'สุโขทัย','สุพรรณบุรี','สุราษฎร์ธานี','สุรินทร์','หนองคาย','หนองบัวลำภู',
                  //     'อ่างทอง','อุดรธานี','อุทัยธานี','อุตรดิตถ์','อุบลราชธานี','อำนาจเจริญ',
                  //   ].map<DropdownMenuItem<String>>((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Text(value),
                  //       );
                  //     }).toList(),
                  //     hint: const Text('เลือกจังหวัด'),
                  //     decoration: InputDecoration(
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(4),
                  //       ),
                  //       fillColor: Colors.white,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 270,
                    height: 65,
                    child: DropdownButtonFormField<String>(
                      value: _typesController.text,
                      onChanged: (String? value) {
                        setState(() {
                          _typesController.text = value!;
                        });
                      },
                      items: <String>['ล้ง', 'ผู้บริโภค', 'ผู้ขาย', 'ชาวสวน']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: const Text('เลือกประเภทผู้ใช้'),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 270,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: saveData, // Pass context here
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffffea00),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'บันทึกข้อมูล',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
