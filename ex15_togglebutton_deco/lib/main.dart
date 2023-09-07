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
      home: const MyHomePage(title: 'Ex16 Togglebutton'),
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
  var isSelected1 = [false, false, true];
  var isSelected2 = [false, false, true];
  var isSelected3 = [false, false, true];
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
            const Text('multi-select', textScaleFactor: 2),
            ToggleButtons(
              onPressed: (int index) {
                setState(() {
                  isSelected1[index] = !isSelected1[index];
                  print('isSelected1 : $isSelected1');
                  print('index : $index');
                });
              },
              isSelected: isSelected1,
              children: const [
                Icon(Icons.ac_unit),
                Icon(Icons.call),
                Icon(Icons.cake),
              ],
            ),
            const SizedBox(height: 20),
            const Text('single select', textScaleFactor: 2),
            ToggleButtons(
              onPressed: (int index) {
                setState(() {
                  for (var i = 0; i < isSelected2.length; i++) {
                    if (i == index) {
                      isSelected2[i] = true;
                    } else {
                      isSelected2[i] = false;
                    }
                  }
                  print('isSelected2 : $isSelected2');
                });
              },
              isSelected: isSelected2,
              children: const [
                Icon(Icons.ac_unit),
                Icon(Icons.call),
                Icon(Icons.cake),
              ],
            ),
            const SizedBox(height: 20),
            const Text('fancy', textScaleFactor: 2),
            ToggleButtons(
              borderColor: Colors.blueGrey,
              borderWidth: 10,
              selectedBorderColor: Colors.blue,
              splashColor: Colors.yellow,
              color: Colors.red,
              selectedColor: Colors.green,
              fillColor: Colors.yellow,
              borderRadius: BorderRadius.circular(10),
              onPressed: (int index) {
                setState(() {
                  for (var i = 0; i < isSelected3.length; i++) {
                    if (i == index) {
                      isSelected3[i] = true;
                    } else {
                      isSelected3[i] = false;
                    }
                  }
                  print('isSelected3 : $isSelected3');
                });
              },
              isSelected: isSelected3,
              children: const [
                Icon(Icons.ac_unit),
                Icon(Icons.call),
                Text('cake'),
              ]
            ),
          ],
        ),
      ),
    );
  }
}