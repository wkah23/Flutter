// 추상 클래스 또는 인터페이스로도 사용가능
abstract class Unit {
  move(); // 동작을 구현하지 않고 ;으로 마무리하여 추상메서드.
          // 다 정의하지 않은 메서드
}

class Marine extends Unit {
  // 기능의 완성. 오버라이딩
  move() {print('마린이 메딕을 들쳐업고 이동');}
}
// extends나 implements나 동일
class Medic implements Unit {
  // 기능의 완성
  move() {print('메딕이 마린등에 업혀서 이동');}
}
void main() {
  var unit1 = Marine();
  unit1.move();

  var unit2 = Medic();
  unit2.move();

  // 추상클래스는 상속을 목적으로 한다. 따라서 아래 객체는 생성할 수 없다.
  // var unit3 = Unit();
}