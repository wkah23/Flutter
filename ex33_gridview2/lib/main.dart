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
      home: const MyHomePage(title: 'Ex33 GridView #2'),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(   // 컬러를 지정하지 않을거면 SizedBox 사용 권장
              height: 300,
              child: GridView.count(
                // scrollDirection: Axis.vertical,  // 스크롤은 세로방향이 기본
                crossAxisCount: 3,    // 타일의 갯수가 자동으로 계산되어 정렬
                childAspectRatio: 1.5,  // 가로,세로 비율
                // int 50의 길이만큼 0부터 index-1 까지 범위의 각 인덱스를
                // 오름차순으로 호출하여 만든 값으로 List를 생성한다.
                children: List.generate(50, (index) {
                  return const Card(
                    color: Colors.blue,
                    child: Icon(
                      Icons.face,
                      color: Colors.yellow,
                      size: 50,
                    ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: 200,
              child: GridView.count(
                scrollDirection: Axis.horizontal,
                crossAxisCount: 2,
                children: List.generate(50, (index) {
                  return const Card(
                    color: Colors.amber,
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
