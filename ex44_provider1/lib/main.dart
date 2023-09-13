import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /*
      기본형인 MaterialApp을 Provider로 감싸면, 앱 전체에서 사용 할수있는
      공유 데이터가 된다.
    */
    return Provider<String>.value(
      value: '홍길동',
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Page1(title: '',),
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
  // 데이터를 읽어 저장할 변수 생성
  String data = '';
  @override
  Widget build(BuildContext context) {
    // listen: false
    data = Provider.of<String>(context);
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
                // 버튼을 누르면 스택에 Page2를 추가한다.
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
            Consumer<String>(
              builder: (context, value, child) {
                print('111111');
                return Text(value, style: const TextStyle(fontSize: 30));
              },
            ),
          ],
        ),
      ),
    );
  }
}
