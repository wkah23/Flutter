import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

late FirebaseApp fbApp;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  fbApp = await Firebase.initializeApp();
  print('Initialized default app $fbApp');
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
      home: const MyHomePage(title: 'Ex65 Firestore'),
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
  late CollectionReference members;
  int seqNum = 0;
  final ctlMyText1 = TextEditingController();

  @override
  void initState() {
    super.initState();
    members = FirebaseFirestore.instance.collection('members');
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
              onPressed: () => doInsert(), 
              child: const Text('회원정보 추가',
                  style: TextStyle(fontSize: 24)),
            ),
            SizedBox(
              width: 240,
              child: TextField(
                controller: ctlMyText1,
              ),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () => doSelectOne(), 
              child: const Text('회원정보 조회',
                  style: TextStyle(fontSize: 24)),
            ),
            ElevatedButton(
              onPressed: () => doUpdate(), 
              child: const Text('회원정보 수정',
                  style: TextStyle(fontSize: 24)),
            ),
            ElevatedButton(
              onPressed: () => doDelete(), 
              child: const Text('회원정보 삭제',
                  style: TextStyle(fontSize: 24)),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> doInsert() async {
    // 회원정보를 Firestore문서로 추가
    String sNum = ctlMyText1.text;
    int nNum = int.parse(sNum);
    String sId = 'member $nNum';

    await members.doc(sId).get();
    members.doc(sId).set({
      'pw' : '1234',
      'email' : 'test1@test.com',
    });
  }
  void doSelectOne() async {
    String sNum = ctlMyText1.text;
    int nNum = int.parse(sNum);
    String sId = 'member $nNum';

    // ignore: non_constant_identifier_names
    var DocumentSnapshot = await members.doc(sId).get();
    if (DocumentSnapshot.data() != null) {
      String pw = DocumentSnapshot.get('pw');
      String email = DocumentSnapshot.get('email');
      print('pw : $pw');
      print('email $email');
    } else {
      print('회원 정보가 존재하지 않습니다.');
    }
  }
  Future<void> doUpdate() async {
    String sNum = ctlMyText1.text;
    int nNum = int.parse(sNum);
    String sId = 'member $nNum';

    // ignore: non_constant_identifier_names
    var DocumentSnapshot = await members.doc(sId).get();
    if (DocumentSnapshot.data() != null) {
      members.doc(sId).update({
        // 'pw' : '0000',
        'email' : 'xxxx@test.com',
      });
    } else {
      print('회원 정보가 존재하지 않습니다.');
    }
  }
  Future<void> doDelete() async {
    String sNum = ctlMyText1.text;
    int nNum = int.parse(sNum);
    String sId = 'member $nNum';

    // ignore: non_constant_identifier_names
    var DocumentSnapshot = await members.doc(sId).get();
    if (DocumentSnapshot.data() != null) {
      // ignore: non_constant_identifier_names
      var DocumentReference = members.doc(sId);
      DocumentReference.delete();
    } else {
      print('회원 정보가 존재하지 않습니다.');
    }
  }
}
