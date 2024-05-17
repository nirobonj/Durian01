import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('HTTP Request Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              try {
                if (kDebugMode) {
                  print("a");
                }
                final response = await http.get(Uri.parse(
                    'https://d2ad-2001-44c8-4116-718-fde5-8134-d0d0-9afe.ngrok-free.app/hello/'));
                if (kDebugMode) {
                  print("b");
                }
                //await http.get(Uri.parse('10.0.2.2/172.20.10.2:8000/etc'));
                if (kDebugMode) {
                  print(response);
                }
                if (response.statusCode == 200) {
                  if (kDebugMode) {
                    print('Response: ${response.body}');
                  }
                } else {
                  if (kDebugMode) {
                    print(
                      'Failed to load data, status code: ${response.statusCode}');
                  }
                }
              } catch (e) {
                if (kDebugMode) {
                  print('Error: $e');
                }
              }
            },
            child: const Text('Send Request'),
          ),
        ),
      ),
    );
  }
}
