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
      home: const MyHomePage(title: 'Ex19 Snackbar'),
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
  // toast보다 SnackBar를 사용하는 것이 더 좋음.
  String msg = 'Hello world';
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
                ScaffoldMessenger.of(context).showSnackBar(
                  /*
                    SnackBar 구현하는 법
                      context는 위에 BuildContext에 있는 객체를
                      그대로 가져오면 된다.
                  */
                  SnackBar(
                    // SnackBar의 내용. icon, button 같은것도 가능하다.
                    content: Text(msg), // 메세지 내용
                    // SnackBar가 닫히는 시간
                    duration: const Duration(milliseconds: 5000),
                    // 추가로 작업을 넣기. 버튼 넣기라 생각하면 편함.
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {},
                    ),
                  ),
                );
              }, 
              child: const Text('SnackBar의 기본',
                  style: TextStyle(fontSize: 24)),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () => callSnackBar('안녕하세요~ 홍길동님!!'), 
              child: const Text('SnackBar 옵션',
                  style: TextStyle(fontSize: 24)),
            ),
          ],
        ),
      ),
    );
  }
  callSnackBar(msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg,
          style: const TextStyle(color: Colors.black,)),
        backgroundColor: Colors.yellow[800],
        duration: const Duration(milliseconds: 5000),
        action: SnackBarAction(
          label: 'Exit',
          textColor: Colors.black,
          onPressed: () {},
        ),
        behavior: SnackBarBehavior.floating,  // floating(아래쪽 부분에서 띄움)
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.red, width: 2,),
        ),
      ),
    );
  }
}
