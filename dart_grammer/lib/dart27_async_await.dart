import 'dart:io';

// async, await는 pair : await는  async내부에서만 사용가능
Future<void> myRequest1() async {
  // 1초씩 딜레이 시켜준다. (10초가 소요되는 매우 긴 작업)
  print('myRequest1() 작업시작');
  for (int i=0; i<10; i++) {
    stdout.write('$i ');
    // await은 함수에만 사용가능. 1초 쉬라는 것.
    await Future.delayed(Duration(seconds: 1));
  }
  print('\nmyRequst1() 작업끝');
}

// Future<int> 객체를 반환하는 메서드
Future<int> myRequest2(num) {
  // 결과가 미래에 생김. 기다리지 않음.
  var req = Future(() {
    print('myRequest2(num) 작업시작');
    int rNum = 0;
    for (int i=0; i<num; i++) {
      rNum += 1;
    }
    print('myRequest2(num) 작업끝');
    return rNum;  // 이결과는 나중에 생김.
  });
  // 위의 결과가 생성되기 전에 리턴하는 것이므로 잘못된 사용법. 시간차공격
  return req;
}
Future<int> myRequest3(num) {
  return Future(() {
    print('myRequest3(num) 작업시작');
    int rNum = 0;
    for(int i=0; i<num; i++) {
      rNum += 1;
    }
    print('myRequest3(num) 작업끝');
    return rNum;
  });
}
void main() async{  // async를 제거하면 아래에서 에러 발생.
  // 비동기를 위한 async와 await은 반드시 같이 사용되어야 한다.
  print('main 시작01');
  myRequest1();
  print('main 끝01');
  // 결과를 기다렸다가 변수에 받음.
  print('main 시작02');
  /*
    Future와 then절을 함께 사용하거나(방법1)
    async와 await을 사용해야한다.
   */
  var val2 = await myRequest2(10);
  var val3 = myRequest3(20);
  val3.then((value) {
    print('then 절 에서 출력 : $value');
  }, onError: (error) {
    print(error);
  });
  print('val2 : $val2');
  print('val3 : $val3');
  print('main 끝02');
}