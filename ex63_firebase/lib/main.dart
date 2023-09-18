import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
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
      home: const MyHomePage(title: 'Ex63 Firebase'),
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
  String name = '';

  FirebaseOptions get firebaseOptions => const FirebaseOptions(
    apiKey: 'AIzaSyCb046UyqaxZeFc_uK7yMnlR191P3nLBCI', 
    appId: '1:256762339198:android:1aded1c259be378e5e9d2f', 
    messagingSenderId: '256762339198', 
    projectId: 'flutter-exam-79a6f'
  );

  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp();
    name = app.name;
    print('Initialized Default app $app');
  }

  Future<void> initializeSecondary() async {
    name = 'myFcm';
    FirebaseApp app = await Firebase.initializeApp(
      name: name,
      options: firebaseOptions
    );
    print('Initialized $app');
  }

  // 헌재는 하나이지만 여러개를 사용할 경우 : FCM, Storage, Auth ...
  void apps() {
    final List<FirebaseApp> apps = Firebase.apps;
    print('Currently initialized apps : $apps');
  }

  void options() {
    final FirebaseApp app = Firebase.app(name);
    final FirebaseOptions options = app.options;
    print('Current options for app $name : $options');
  }

  Future<void> delete() async {
    final FirebaseApp app = Firebase.app(name);
    await app.delete();
    print('App $name deleted');
  }

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
              onPressed: initializeDefault, 
              child: const Text('Initialize Default app'),
            ),
            ElevatedButton(
              onPressed: initializeSecondary, 
              child: const Text('Initialize secondary app'),
            ),
            ElevatedButton(
              onPressed: apps, 
              child: const Text('Get apps'),
            ),
            ElevatedButton(
              onPressed: options, 
              child: const Text('List options'),
            ),
          ],
        ),
      ),
    );
  }
}
