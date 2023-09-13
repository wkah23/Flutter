import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PageA2 extends StatefulWidget {
  const PageA2({super.key});

  @override
  State<PageA2> createState() => _PageA2State();
}

class _PageA2State extends State<PageA2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Page A-2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Page A-2', style: TextStyle(fontSize: 30)),
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