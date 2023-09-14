import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';  // utf8.decode

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Ex50 Http exam'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _getRequest();
              },
              // 레코드 조회
              child: const Text('Http (Get)',
                  style: TextStyle(fontSize: 24)),
            ),
            ElevatedButton(
              onPressed: () {
                _postRequest();
              }, 
              // 레코드 입력
              child: const Text('Http (Post)',
                  style: TextStyle(fontSize: 24)),
            ),
          ],
        ),
      ),
    );
  }
  void _getRequest() async {
    var url = Uri.parse('https://sample.bmaster.kro.kr/contacts/1693362250806');
    http.Response response = await http.get(
      url,
      // json으로 가져온다.
      headers: {'Accept' : 'application/json'}
    );
    // 접속 상태
    var statusCode = response.statusCode;
    // 응답 헤더
    // var responseHeaders = response.headers;
    // 요청 레코드 정보
    var responseBody = utf8.decode(response.bodyBytes);

    print('statusCode : $statusCode');
    // print('responseHeaders : $responseHeaders');
    print('responseBody : $responseBody');
  }
  void _postRequest() async {
    var url = Uri.parse('https://sample.bmaster.kro.kr/contacts');
    // 데이터를 입력 요청
    http.Response response = await http.post(
      url,
      headers: {
        'Content-Type' : 'application/x-www-form-urlencoded',
      },
      body: {
        'name' : '내가 누구게',
        'tel' : '010-1472-5378',
        'address' : '서울시 강서구'
      },
    );
    var statusCode = response.statusCode;
    // var responseHeaders = response.headers;
    var responseBody = utf8.decode(response.bodyBytes);
    print('statusCode : $statusCode');
    // print('responseHeaders : $responseHeaders');
    print('responseBody : $responseBody');
  }
}
