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
                final response = await http.get(Uri.parse(
                    'https://zbx5wgnt-8000.asse.devtunnels.ms/hello/'));
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
