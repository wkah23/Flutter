import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'Ex21 Alert Dialog'),
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
  String _sPersonName = '';
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
              onPressed: () => _showAlertDialog(context, 'hello~'), 
              child: const Text('Show AlertDialog',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future _showAlertDialog(BuildContext context, String message) async {
    await showDialog(
      context: context, 
      /*
        화면의 빈곳을 눌러도 창이 닫히지 않음
        true인 경우에는 창이 닫히게 된다.
      */
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Theme(
          // 배경색
          data: ThemeData(dialogBackgroundColor: Colors.orange), 
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            title: const Text('AlertDialog Example'),
            content: SizedBox(
              height: 100,
              child: Column(
                children: [
                  Text(message),  // 전달받은 메세지 출력
                  TextField(
                    autofocus: true,
                    // 입력상자의 힌트 설정
                    decoration: const InputDecoration(
                      labelText: 'Name', hintText: '홍길동'
                    ),
                    // 입력된 내용을 전역변수에 저장
                    onChanged: (value) {
                      // 버튼을 누르면 대화창을 닫음.
                      _sPersonName = value;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'OK');
                  print('OK - $_sPersonName');
                }, 
                child: const Text('OK'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                  print('Cancel');
                }, 
                child: const Text('Cancel'),
              ),
            ],
          ),
        );
      },
    );
  }
}
