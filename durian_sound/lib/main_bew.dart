import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    title: 'Car Dropdown',
    home: CarDropdown(),
  ));
}

class CarDropdown extends StatefulWidget {
  const CarDropdown({super.key});

  @override
  _CarDropdownState createState() => _CarDropdownState();
}

class _CarDropdownState extends State<CarDropdown> {
  late List<String> _cars = [];
  late String? _selectedCar;

  Future<void> fetchCars() async {
    final response = await http.get(
        Uri.parse('https://7ee9-115-87-222-240.ngrok-free.app/users/hello'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        _cars = List<String>.from(jsonData['cars']);
      });
    } else {
      throw Exception('Failed to load cars');
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedCar = null; // กำหนดค่าเริ่มต้นเป็น null ใน initState
    fetchCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Dropdown'),
      ),
      body: Center(
        child: DropdownButton<String?>(
          value: _selectedCar,
          onChanged: (String? newValue) {
            setState(() {
              _selectedCar = newValue;
            });
          },
          items: _cars.map<DropdownMenuItem<String>>((String car) {
            return DropdownMenuItem<String>(
              value: car,
              child: Text(car),
            );
          }).toList(),
        ),
      ),
    );
  }
}
