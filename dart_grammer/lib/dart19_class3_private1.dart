import 'package:dart_grammer/dart19_class3_private2.dart';

class Unit {
  // 변수명 그냥 쓰면 public,  _ 로 시작하면 private (암묵적)
  late String _name;
  late int age;
  // 생성자 간단하게 사용하기
  //  어차피 연결할 거... 파라미터 부분에서...
  Unit(this._name, this.age);
}

void main() {
  // Unit 클래스는 같은 라이브러리 이므로 prpivate 멤버도 접근 가능하다.
  var unit1 = Unit("마린", 25);
  print(unit1._name); // private 이지만 에러없이 출력됨 (Java에서는 에러)
  print(unit1.age);

  // Unit2 클래스의 경우 외부에서 정의되었으므로 private 멤버는 접근 불가능하다.
  var unit2 = Unit2("메딕", 20);
  // print(unit2._name);  // private 적용됨 다른 파일 이므로 에러남
  print(unit2.age);
}
/*
  Dart에서는 하나의 파일이 하나의 library이다.
  그래서 private으로 할 경우 해당 파일에만 or 해당 라이브러리에만 접근이 가능.
  외부파일 에서는 접근이 불가능하다.
 */