import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Page1 extends StatefulWidget {
  String data = '';
  Page1({super.key, required this.data});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
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
              onPressed: () async {
                // Route에서는 push()대신 pushNamed()(경로를 지정)를 사용.
                // 새로운 페이지에서 콜백데이터가 올때까지 대기(await)한다.
                // 결과 데이터를 받을 변수는 var로 선언한다.
                // String으로 받으면 에러가 발생한다. 이미 있는 페이지를 부름.
                var result = await Navigator.pushNamed(context, '/page2');
                print('result(from 2) : $result');
                // 콜백 데이터를 화면에 적용하기 위해 재랜더링한다.
                setState(() {
                  // 결과 데이터를 명시적으로 String으로 형변환 후 data에 설정
                  widget.data = result as String;
                });
              }, 
              child: const Text('2페이지 추가', style: TextStyle(fontSize: 24)),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () async {
                await Navigator.pushNamed(context, '/page3')
                .then((result) {
                  print('result(from 3) : $result');
                  setState(() {
                    widget.data = result as String;
                  });
                });
              }, 
              child: const Text('3페이지 추가', style: TextStyle(fontSize: 24)),
            ),
            Text(widget.data, style: const TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}