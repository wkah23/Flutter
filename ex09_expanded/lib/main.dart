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
      home: const MyHomePage(title: 'Ex09 Expanded'),
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
  String _image1 = 'assets/images/900.png';
  String _image2 = 'assets/images/placeholder.png';
  // String _image3 = 'assets/images/900x600.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          // 세로형 배치
          mainAxisAlignment: MainAxisAlignment.start, // 위에서부터
          children: [
            Expanded(
              flex: 5,  // HTML의 %와 유사한 속성으로 위젯의 비율을 설정. 비율 10기준
              child: Container(
                margin: const EdgeInsets.all(0.0),  // 마진
                padding: const EdgeInsets.all(0.0), // 패딩
                color: Colors.cyan,              // 배경색
                alignment: Alignment.topLeft,      // 정렬
                child: Image.asset(
                  _image1, 
                  alignment: Alignment.topLeft,
                  // alignment: Alignment.topCenter,
                  // alignment: Alignment.bottomRight,
                  // fit: BoxFit.none,  // 원래 크기대로...
                  width: 390.0, 
                  height: 250.0,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 10),
              padding: const EdgeInsets.all(0.0),
              color: Colors.red,
              width: 300,   // 크기를 지정하지 않으면 부모의 크기
              height: 100,  // 크기를 지정하지 않으면 자식의 크기
              // alignment: Alignment.center,
              child: Row( //가로형 배치
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.upload_sharp),
                    tooltip: '이미지가 위로 이동',
                    iconSize: 50.0,
                    onPressed: () => _onClick1(),
                  ),
                  // 수평방향으로 간격 설정, 사이간격 줄때 많이 사용한다.
                  const SizedBox(width: 20),
                  IconButton(
                    icon: const Icon(Icons.download_sharp),
                    tooltip: '이미지가 아래로 이동',
                    iconSize: 50.0,
                    onPressed: () => _onClick2(),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.all(0.0),
                padding: const EdgeInsets.all(0.0),
                color: Colors.cyan,
                alignment: Alignment.topLeft,
                child: Image.asset(   // image asset 하려면 재 실행 할 것
                  _image2, 
                  alignment: Alignment.topLeft,
                  // fit: BoxFit.none,
                  width: 390.0, height: 250.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _onClick1() {
    /*
      상태 변경을 위해 사용하는 메서드로 특정 변수를 변경시키게 되면 화면의
      랜더링이 다시 진행되면서 변경된 화면을 볼 수 있게 된다.
    */
    setState(() {
      _image1 = 'assets/images/900.png';
      _image2 = 'assets/images/placeholder.png';
    });
  }
  void _onClick2() {
    setState(() {
      _image1 = 'assets/images/placeholder.png';
      _image2 = 'assets/images/900.png';
    });
  }
}
