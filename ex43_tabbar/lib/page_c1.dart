import 'package:flutter/material.dart';
import 'page_c2.dart';

// ignore: must_be_immutable
class PageC1 extends StatefulWidget {
  const PageC1({super.key});

  @override
  State<PageC1> createState() => _PageC1State();
}

class _PageC1State extends State<PageC1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Page C-1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Page C-1', style: TextStyle(fontSize: 30)),
            const SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  // MaterialPageRoute(builder: (context) => const PageA2()),
                  PageRouteBuilder(
                    pageBuilder: (context, anim1, anim2) => const PageC2(),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              },
              child: const Text('2페이지 추가',
                  style: TextStyle(fontSize: 24)),
            ),
          ],
        ),
      ),
    );
  }
}