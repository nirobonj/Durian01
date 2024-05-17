import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:durian_sound/config.dart';
import 'package:durian_sound/setting_page.dart'; // Import the SettingPage

class EditFormPage extends StatefulWidget {
  final String defaultUsername;
  const EditFormPage({required this.defaultUsername, Key? key})
      : super(key: key);

  @override
  _EditFormPageState createState() => _EditFormPageState();
}

class _EditFormPageState extends State<EditFormPage> {
  String message = '';
  Map<String, dynamic>? userData;
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _telController = TextEditingController();
  TextEditingController _provinceController = TextEditingController();
  TextEditingController _typesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('${AppConfig.connUrl}/users/edit/${widget.defaultUsername}'),
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
      });
    } else {
      print('Failed to fetch data.');
    }
  }

  Future<void> saveData() async {
    final url =
        Uri.parse('${AppConfig.connUrl}/users/edit/${widget.defaultUsername}');
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
        }),
      );

      if (response.statusCode == 200) {
        showSuccessDialog();
      } else {
        print('Failed to save data.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('สำเร็จ'),
          content: Text('บันทึกข้อมูลสำเร็จ'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SettingPage()),
                );
              },
              child: Text('ตกลง'),
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User Data'),
      ),
      body: Center(
        child: userData == null
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _firstnameController,
                    decoration: InputDecoration(labelText: 'First Name'),
                  ),
                  TextFormField(
                    controller: _lastnameController,
                    decoration: InputDecoration(labelText: 'Last Name'),
                  ),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                  TextFormField(
                    controller: _telController,
                    decoration: InputDecoration(labelText: 'Telephone'),
                  ),
                  DropdownButtonFormField<String>(
                    value: _provinceController.text,
                    onChanged: (String? value) {
                      setState(() {
                        _provinceController.text = value!;
                      });
                    },
                    items: <String>[
                      'กรุงเทพมหานคร',
                      'กระบี่',
                      'กาญจนบุรี',
                      'ปทุมธานี',
                      'กาฬสินธุ์',
                      'กำแพงเพชร',
                      'ขอนแก่น',
                      'จันทบุรี',
                      'ฉะเชิงเทรา',
                      'ชลบุรี',
                      'ชัยนาท',
                      'ชัยภูมิ',
                      'ชุมพร',
                      'เชียงราย',
                      'เชียงใหม่',
                      'ตรัง',
                      'ตราด',
                      'ตาก',
                      'นครนายก',
                      'นครปฐม',
                      'นครพนม',
                      'นครราชสีมา',
                      'นครศรีธรรมราช',
                      'นครสวรรค์',
                      'นนทบุรี',
                      'นราธิวาส',
                      'น่าน',
                      'บึงกาฬ',
                      'บุรีรัมย์',
                      'ปทุมธานี',
                      'ประจวบคีรีขันธ์',
                      'ปราจีนบุรี',
                      'ปัตตานี',
                      'พังงา',
                      'พัทลุง',
                      'พิจิตร',
                      'พิษณุโลก',
                      'เพชรบุรี',
                      'เพชรบูรณ์',
                      'แพร่',
                      'พะเยา',
                      'ภูเก็ต',
                      'มหาสารคาม',
                      'มุกดาหาร',
                      'แม่ฮ่องสอน',
                      'ยะลา',
                      'ยโสธร',
                      'ร้อยเอ็ด',
                      'ระนอง',
                      'ระยอง',
                      'ราชบุรี',
                      'ลพบุรี',
                      'ลำปาง',
                      'ลำพูน',
                      'เลย',
                      'ศรีสะเกษ',
                      'สกลนคร',
                      'สงขลา',
                      'สตูล',
                      'สมุทรปราการ',
                      'สมุทรสงคราม',
                      'สมุทรสาคร',
                      'สระแก้ว',
                      'สระบุรี',
                      'สิงห์บุรี',
                      'สุโขทัย',
                      'สุพรรณบุรี',
                      'สุราษฎร์ธานี',
                      'สุรินทร์',
                      'หนองคาย',
                      'หนองบัวลำภู',
                      'อ่างทอง',
                      'อุดรธานี',
                      'อุทัยธานี',
                      'อุตรดิตถ์',
                      'อุบลราชธานี',
                      'อำนาจเจริญ',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(labelText: 'Province'),
                  ),
                  DropdownButtonFormField<String>(
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
                    decoration: InputDecoration(labelText: 'Types'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: saveData,
                    child: Text('บันทึก'),
                  ),
                ],
              ),
      ),
    );
  }
}
