import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('HTTP Request Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              try {
                print("a");
                final response = await http.get(Uri.parse(
                    'https://d2ad-2001-44c8-4116-718-fde5-8134-d0d0-9afe.ngrok-free.app/hello/'));
                print("b");
                //await http.get(Uri.parse('10.0.2.2/172.20.10.2:8000/etc'));
                print(response);
                if (response.statusCode == 200) {
                  print('Response: ${response.body}');
                } else {
                  print(
                      'Failed to load data, status code: ${response.statusCode}');
                }
              } catch (e) {
                print('Error: $e');
              }
            },
            child: Text('Send Request'),
          ),
        ),
      ),
    );
  }
}
