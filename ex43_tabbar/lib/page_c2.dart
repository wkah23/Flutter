import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PageC2 extends StatefulWidget {
  const PageC2({super.key});

  @override
  State<PageC2> createState() => _PageC2State();
}

class _PageC2State extends State<PageC2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Page C-2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Page C-2', style: TextStyle(fontSize: 30)),
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