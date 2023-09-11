void main() {
  // Positional parameters : 매개변수를 이름을 통해 부여할 수 있다.
  //                    따라서 순서를 변경할 수 없다. list[]처럼 위치로 찾아감.

  something1();
  something1('홍길동');

  something2('해리포터');
  something2('멀린', 20);

  something3('전우치');
  something3('손오공', 20);

  something4('이순신');
  something4('강감찬', 20);
}
void something1([String? name]) {   // String? => null 값 허용
  print('name : $name');
}
void something2([String? name, int? age]) {
  print('name : $name age : $age');
}
void something3(String name, [int? age]) {
  print('name : $name age : $age');
}
void something4(String name, [int age = 10]) {
  print('name : $name age : $age');
}