void main() {
  // Set : 데이터 순서가 없고 중복 허용하지 않음
  /*
    List는 배열과 같아서 인덱스가 있고, 중복이 허용된다.
    Set은 집합과 같아서 데이터의 순서가 없고, 중복이 허용되지 않는다.
   */
  // Set<String> set1 = {'c', 'b', 'a', 'a'};
  // 초기값 에러. 버전에 따라 다름 (VS모드), 편집 프로그램에 따라 다름.
  // 안드로이드스튜디오, VScode 다름.
  
  // <String> 으로 저장
  Set<String> set1 = {'c', 'b', 'a'};
  print(set1);

  set1.add('a');
  set1.add('d');
  print(set1);

  set1.remove('c');
  print(set1);

  var bCheck = set1.contains('b');  // contains는 존재하는 경우 true를 반환
  if (bCheck) {
    print("b는 존재하는 값 입니다.");
  }
  // 인덱스 개별 값 접근 (일반 for문) 단 List와 같은 방법이 아님에 유의할 것.
  for (int i=0; i<set1.length; i++) {
    print('set1[${i}] -> ${set1.elementAt(i)}');
  }
  for (dynamic each in set1) {
    print(each);
  }
  var set2 = {...set1, 'x', 'y', 'z'};
  print(set2);
}