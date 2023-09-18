import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';  // 의존성 추가할 때 버전넣기 path: ^1.8.3

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.
  key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Ex57 SQLite #1'),
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
  // sqlite 사용을 위한 데이터베이스 객체 생성
  late Future<Database> database;
  int seqNum = 0;
  // 텍스트필드에 입력된 내용을 얻어오기 위한 컨트롤러
  final ctlMyText1 = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 앱이 최초 시작될때 데이터베이스 생성
    createDatabase();
  }
  void createDatabase() async {
    database = openDatabase(
      // 각 플랫폼 별로 데이터베이스 경로 생성
      // 'path' 패키지의 'join' 함수를 사용
      join(await getDatabasesPath(), 'telbook.db'),
      // 데이터베이스가 처음 생성될 때, 테이블 생성.
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE telbook( "  // + 생략해도 된다.
          " id INTEGER PRIMARY KEY, name TEXT, telnum TEXT)",
        );
      },
      // onCreate 함수에 DB 업그레이드와 다운그레이드를 위한 경로 제공
      version: 1,
    );
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
              child: const Text('Insert',
                  style: TextStyle(fontSize: 24)),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () => doSelectAll(), 
              child: const Text('Select All',
                  style: TextStyle(fontSize: 24)),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              width: 240,
              child: TextField(
                controller: ctlMyText1,
              ),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                // 텍스트 필드에 입력된 내용(일련번호)을 얻어온다.
                var sNum = ctlMyText1.text;
                // 얻어온 내용을 int형으로 변환한다.
                int nNum = int.parse(sNum);
                doSelectOne(nNum);
              }, 
              child: const Text('Select One',
                  style: TextStyle(fontSize: 24)),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                var sNum = ctlMyText1.text;
                int nNum = int.parse(sNum);
                doUpdate(nNum);
              }, 
              child: const Text('Update',
                  style: TextStyle(fontSize: 24)),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                var sNum = ctlMyText1.text;
                int nNum = int.parse(sNum);
                doDelete(nNum);
              }, 
              child: const Text('Delete',
                  style: TextStyle(fontSize: 24)),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () => doDeleteAll(),
              child: const Text('Delete All',
                  style: TextStyle(fontSize: 24)),
            ),
          ],
        ),
      ),
    );
  }
  void doSelectAll() async {
    // 데이터베이스 reference를 얻기
    final Database db = await database;
    // Select한 결과는 List로 반환한다.
    List<Map> datas = await db.rawQuery('Select * from telbook');
    /*
      컬렉션에 어떤 것이 포함되어 있는지 확인하기 위해서 호출
      length 하는것은 느릴 수 있다. 대신 더 빠르고 읽기 쉬운 게터가 있다.
      isEmpty및 isNotEmpty. 결과를 부정할 필요가 없는 것을 사용할 필요가 있다.
    */
    if (datas.isNotEmpty) {   // datas.length > 0 보다 가벼운 코드
      for (int i = 0; i < datas.length; i++) {
        // 각 레코드는 인덱스 i를 통해 접근하여 컬럼명으로 값을 얻어온다.
        int id = datas[i]['id'];
        String name = datas[i]['name'];
        String telnum = datas[i]['telnum'];

        print('$id $name $telnum');
      }
    } else {
      print('SelectAll : 데이터가 없습니다.');
    }
  }

  void doSelectOne(int num) async {
    // 데이터베이스 reference를 얻기
    final Database db = await database;

    List<Map> data = await db.rawQuery('Select * from telbook where id = $num');
    print(data);
    if (data.isNotEmpty) {
        int id = data[0]['id'];
        String name = data[0]['name'];
        String telnum = data[0]['telnum'];

        print('$id $name $telnum');
      
    } else {
      print('SelectOne : 데이터가 없습니다.');
    }
  }
  
  Future<void> doInsert() async {
    final Database db = await database;
    // 시퀀스로 사용할 변수
    seqNum = seqNum + 1;
    var telnum = '010-1234-$seqNum$seqNum$seqNum$seqNum';
    // 쿼리문은 인파라미터 ? 가 있는 형태로 작성한다.
    int count = await db.rawInsert(
      'insert into telbook (id, name, telnum) values (?, ?, ?)',
      [seqNum, '홍길동$seqNum', telnum]);
    
    print('Insert : $count');
  }

  Future<void> doUpdate(int id) async {
    final db = await database;

    int count = await db.rawUpdate(
      'Update telbook set name = ?, telnum = ? where id = ?',
      ['손오공', '010-1234-xxxx', id]);
    
    print('Update : $count');
  }

  Future<void> doDelete(int id) async {
    final db = await database;

    int count = await db.rawDelete(
      'Delete from telbook where id = ?', [id]);
    
    print('Delete : $count');
  }

  Future<void> doDeleteAll() async {
    final db = await database;
    int count = await db.rawDelete('Delete from telbook');
    print('DeleteAll : $count');
  }
}
