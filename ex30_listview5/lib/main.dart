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
      home: const MyHomePage(title: 'Ex30 ListView #5'),
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
      body: Container(
        margin: const EdgeInsets.all(0.0),
        padding: const EdgeInsets.all(0.0),
        // width: 250,
        // height: 250,
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              alignment: Alignment.center,
              color: Colors.amber[700],
              child: const Text('Entry A', style: TextStyle(fontSize: 30)),
            ),
            SizedBox(
              width: double.infinity,
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(8),
                itemCount: persons.length,
                itemBuilder: (BuildContext context, int index) {
                  return PersonTile(persons[index], index);
                },
              ),
            ),
            Container(
              width: double.infinity,
              height: 200,
              alignment: Alignment.center,
              color: Colors.amber[500],
              child: const Text('Entry B', style: TextStyle(fontSize: 30)),
            ),
            Container(
              width: double.infinity,
              height: 200,
              alignment: Alignment.center,
              color: Colors.amber[300],
              child: const Text('Entry C', style: TextStyle(fontSize: 30)),
            ),
            Container(
              width: double.infinity,
              height: 200,
              alignment: Alignment.center,
              color: Colors.amber[100],
              child: const Text('Entry D', style: TextStyle(fontSize: 30)),
            ),
          ],
        ),
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
                child: const Text('ElevatedButton',
                    style: TextStyle(fontSize: 13)),
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
