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
      home: const MyHomePage(title: 'Ex14 Checkbox & Switch'),
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
  // 체크박스와 스위치에서 사용할 전역변수(매개변수) 생성
  bool _chk1 = false;
  bool? _chk2 = false;  // Nullable - null값 허용
  bool _chk3 = false;
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
            // 기본상태의 체크박스
            Checkbox(
              value: _chk1, // 체크박스에서 사용할 값 지정
              // 체크 or 언체크시 이벤트 처리
              // 위에서 bool을 ? 안했기 때문에 이곳에서는 bool? 사용
              onChanged: (bool? value) {  // 이벤트체크
              // 매개변수를 Nullable로 지정
                setState(() { // 변경 후 UI를 다시 그린다.
                /*
                  null check operator
                    : 변수뒤에 !을 추가하면 이 변수 값이 null인 경우
                    runtime error가 발생한다.
                */
                  _chk1 = value!;
                });
                print('Checkbox1 : $_chk1');
              }),
            Checkbox(
              value: _chk2,
              checkColor: Colors.pink,
              activeColor: Colors.green,
              onChanged: (value) {
                setState(() {
                  _chk2 = value;
                });
                print('Checkbox2 : $_chk2');
              }),
            Switch(
              value: _chk3,
              activeColor: Colors.red, // 스위치가 켜졌을 때 색깔
              activeTrackColor: Colors.cyan,   // 체크되었을 때 배경색
              inactiveThumbColor: Colors.lightGreen, // 스위치가 꺼졌을때 색
              inactiveTrackColor: Colors.lightGreenAccent, // 체크 안되었을때 배경색
              // 스위치에서 null값이 안나오므로 bool? 처리 안하면 ! 실행시에도 안함.
              onChanged: (value) {
                setState(() {
                  _chk3 = value;
                });
                print('Switch : $_chk3');
              }),
          ],
        ),
      ),
    );
  }
}
