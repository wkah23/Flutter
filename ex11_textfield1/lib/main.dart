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
      home: const MyHomePage(title: 'Ex12 Textfield #1'),
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
  String _myText = '김희지';
  final ctlMyText1 = TextEditingController();

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _myText,
              style: const TextStyle(fontSize: 30.0),
            ),
            // 텍스트 필드의 가로사이즈는 SizedBox를 통해 설정
            SizedBox(
              width: 280,
              child: TextField(
                // TextField의 Controller로 지정해 준다.
                controller: ctlMyText1,
              ),
            ),
            ElevatedButton(
              // 플로팅 버튼을 통해 초기상태로 변경한다.
              onPressed: () {
                // 입력한 텍스트로 상태를 변경하면서 렌더링을 다시한다.
                setState(() {
                  /*
                    TextField의 값을 불러오고 싶을 땐, TextField.value가
                    아니고 ctlMyText1.text로 접근하면 된다.
                  */
                  _myText = ctlMyText1.text;
                });
              }, 
              child: const Text('텍스트 입력 버튼',
                style: TextStyle(fontSize: 24)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _myText = '김희지';
          });
        },
        child: const Icon(Icons.access_time_filled),
      ),
    );
  }
}
