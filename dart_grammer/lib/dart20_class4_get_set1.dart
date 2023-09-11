import 'dart20_class4_get_set2.dart';

void main() {
  var unit1 = Unit();

  // unit._age = 30;  // private 변수라 접근 안됨
  // unit.age(30);    // 자바의 메서드 호출 방식 X
  unit1.age = 30;     // 변수에 접근하듯이 사용. 여기에선 의미상 setter
  print(unit1.age);   // 여기에선 의미상 getter

  // 그냥 변수명을 사용하는 것과 똑같지만
  // 메서드 이므로 값의 변경이 가능하다.

  // 계단식 표기법 ..연산자를 통해 연속해서 메서드 호출하기. (캡슐화)
  var unit2 = Unit()
  ..setName('희지')
  ..setAge(26);
  print('이름 : ${unit2.name}, 나이 : ${unit2.age}');

  // 일반적인 메서드 호출방식
  // unit2.setName('커멘드센터');
  // unit2.setAge(1000);
  // print('이름 : ${unit2.name}, 나이 : ${unit2.age}');
}