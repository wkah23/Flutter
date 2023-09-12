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
      home: const MyHomePage(title: 'Ex34 GridView #3'),
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
  late List<Person> persons;

  @override
  void initState() {
    super.initState();
    persons = [];
    for (int i = 0; i < 15; i++) {
      persons.add(Person(i+21, '홍길동${i+1}', true));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SizedBox(   // color가 없으면 SizedBox를 권장
        // width: double.infinity,
        // height: 400.0,   // 자식크기로 설정
        child: GridView.count(
          padding: const EdgeInsets.all(10),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          childAspectRatio: 0.7,
          children: getGridPage(),
        ),
      ),
    );
  }
  List<Widget> getGridPage() {
    // 그리드로 사용할 리스트 생성
    List<Widget> grid = [];
    for (int i = 0; i < persons.length; i++) {
      Widget myWidget = Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(2),
        color: Colors.blue[100],
        child: PersonTile(persons[i], i),
      );
      grid.add(myWidget);
    }
    return grid;
  }
}
class Person {
  int age;
  String name;
  bool isLeftHand;

  Person(this.age, this.name, this.isLeftHand);
}
class PersonTile extends StatelessWidget {
  final Person _person;
  final int index; 
  const PersonTile(this._person, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card( 
      color: Colors.amber[100],
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        splashColor: Colors.blue, 
        onTap: () {
          print('${index+1}번 타일 클릭됨');
        },
        child: SizedBox(
          width: 140,
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 100,
                alignment: Alignment.center,
                color: Colors.blue[50],
                child: Column(
                  children: [
                    Text(
                      _person.name,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "'${_person.age}세'",
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal, 
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => _onClick(index), 
                child: const Text('Button',
                    style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _onClick(int index) {
    print('${index+1} 클릭됨');
  }
}
