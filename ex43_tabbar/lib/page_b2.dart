import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PageB2 extends StatefulWidget {
  const PageB2({super.key});

  @override
  State<PageB2> createState() => _PageB2State();
}

class _PageB2State extends State<PageB2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Page B-2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Page B-2', style: TextStyle(fontSize: 30)),
            const SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('2페이지 제거',
                  style: TextStyle(fontSize: 24)),
            ),
          ],
        ),
      ),
    );
  }
}