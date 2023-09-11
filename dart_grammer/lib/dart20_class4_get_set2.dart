class Unit {
  // 정보 은닉화를 위하여 멤버 변수를 private으로 선언.
  late String _name;
  late int _age;

  set name(String value) {
    _name = value;
  }

  int get age => _age;

  set age(int value) {
    _age = value;
  }

  // String get name => _name;
  // String get name => 'My name is $_name.';
  String get name {
    return 'My name is $_name and I love g9u_gi';
  }
  
  // 일반 메서드 형태로 세터 메서드 직접 생성
  // 자바에서 사용하는 getter, setter. 이렇게 사용해도 된다.
  void setName(String name) {
    this._name = name;
  }
  void setAge(int age) {
    this._age = age;
  }
}