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
      home: const MyHomePage(title: 'Ex29 List View #4'),
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
  // 나중에 초기화 될 것임을 명시함. 데이터로 사용할 컬렉션
  late List<Person> persons;
  //  위젯 초기화 시 딱 한번만 호출되는 함수로 변경했을 때 Hot reload가
  // 지원되지 않으므로 재시작 해야한다.
  @override
  void initState() {
    super.initState();
    persons = []; // 초기화
    // 데이터로 사용하기위한 반복
    for (int i = 0; i < 15; i++) {
      persons.add(Person(i+21, '홍길동$i', true));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.separated(
        itemCount: persons.length,
        itemBuilder: (BuildContext context, int index) {
          // Person 객체외에 추가데이터인 index를 사용한다.
          return PersonTile(persons[index], index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider( // 구분선
            color: Colors.transparent,
            height: 1,  // 구분선은 해당 속성에 따라 다른 결과를 출력한다.
            // thickness: 1.0,
          );
        },
      ),
    );
  }
}
class Person {
  int age;
  String name;
  bool isLeftHand;

  Person(this.age, this.name, this.isLeftHand);
}
/*
  StatelessWidget 클래스는 build() 메서드를 가지고 있다. build() 메서드는
  위젯을 생성할 때 호출되는데, 실제로 화면에 그릴 위젯을 작성해 반환한다.
  따라서 StatelessWidget 클래스를 상속받은 PersonTile 클래스는 ListTile
  클래스의 인스턴스를 작성해서 반환한다.
*/
class PersonTile extends StatelessWidget {
  // 멤버변수와 생성자 정의
  final Person _person;
  final int index;  // 타일에 추가 데이터가 필요한 경우 생성자에 추가하면 된다.
  // 필수 매개변수, {선택형 매개변수}
  const PersonTile(this._person, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    // 리스트 타일 대신 Card를 사용.
    return Card( 
      color: Colors.amber[100],
      elevation: 0,
      // 카드의 테두리 속성 (색깔, 두께, 원형적용)
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        splashColor: Colors.blue, // 클랙했을 때 변환하는 색깔
        onTap: () {
          print('${index+1}번 타일 클릭됨');
        },
        child: Row(
          children: [
            const SizedBox(
              width: 100,
              height: 150,
              child: Icon(
                Icons.account_box,
                size: 50.0,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _person.name,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    "'${_person.age}세'",
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal, 
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${index+1}번 타일',
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Padding(
                        // 엘리베이티드 버튼 추가 클릭시 외부 메서드 호출
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                          onPressed: () => _onClick(index), 
                          child: const Text('ElevatedButton',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _onClick(int index) {
    print('${index+1} 클릭됨');
  }
}
