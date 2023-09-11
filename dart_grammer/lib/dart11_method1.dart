void main () {
  something1('홍길동');

  something2('전우치');
  something2(30);

  // named parameters : 매개변수를 이름을 통해 부여할 수 있다.
  //                    따라서 순서를 변경할 수 있다. set{}처럼 key값으로 찾아감.

  something3(); // 이렇게 {}있는 것은 사용해도 되고 안해도 됨.
  something3(name : '손오공');

  // 옵션이 있는것은 아래와 같이 사용하면 됨. 하나만 사용해도 되고, 둘다 사용해도 됨.
  // 형식은 (key : value) 만 지켜지면 된다.
  something4(age : 20);

  something5('해리포터');
  something5('멀린', age : 20);

  something6('이순신');
  something6('강감찬', age : 20);

  something7('권율', age : 30);
}

void something1(String name) {
  print(name);
}
// 파라미터 타입을 생략하면 dynamic 타입이 됨
// (어떤 타입(숫자, 문자)이던 전달 가능)
void something2(name) {
  print(name);
}
// 파라미터 옵션 처리. {}있는 것은 데이터를 사용해도 되고 안해도 된다.
// 쓸때는 name: 값을 넣어야 한다.
void something3({String? name}) { // null 체크
  print('name : $name');
}
void something4({String? name, int? age}) {
  print('name : $name age : $age');
}
void something5(String name, {int? age}) {
  print('name : $name age : $age');
}
void something6(String name, {int age = 10}) {
  print('name : $name age : $age');
}
void something7(String name, {required int age}) {
  print('name : $name age : $age');
}