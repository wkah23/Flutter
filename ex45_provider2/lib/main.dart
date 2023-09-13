import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 2개 이상의 Provider를 사용할 수 있다.
    return MultiProvider(
      /*
        동일한 Provider가 존재하면 마지막에 선언된 것이 사용된다.
      */
      providers: [
        Provider<String>.value(value: '홍길동'),
        Provider<String>.value(value: '전우치'),
        Provider<int>.value(value: 20),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Page1(title: ''),
      ),
    );
  }
}

class Page1 extends StatefulWidget {
  const Page1({super.key, required this.title});

  final String title;

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  String data = '';
  int number = 0;
  @override
  Widget build(BuildContext context) {
    // 데이터 사용 - 변경에 대한 알림 받기
    // 그리고 데이터만 변경하고 UI를 변경하지 않는 곳에서는 false를 해야된다.
    data = Provider.of<String>(context, listen: true);
    number = Provider.of<int>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Page 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const Page2(title: '',)),
                );
              }, 
              child: const Text('2페이지 추가',
                  style: TextStyle(fontSize: 24)),
            ),
            Text(data, style: const TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  const Page2({super.key, required this.title});

  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  String data = '';
  @override
  Widget build(BuildContext context) {
    // listen: false
    data = Provider.of<String>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Page 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text('2페이지 제거',
                  style: TextStyle(fontSize: 24)),
            ),
            // 데이터 사용 - 데이터 변경이 일어나면 builder에 지정된 익명함수가
            // 호출되고 지정된 위젯만 재빌드된다. Provider가 2개이므로
            // Consumer2<데이터1, 데이터2>를 사용한다.
            Consumer2<String, int>(
              builder: (context, data1, data2, child) {
                print(11111);
                return Text('$data1 - $data2', style: const TextStyle(fontSize: 30));
              },
            ),
          ],
        ),
      ),
    );
  }
}
