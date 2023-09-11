void main() {
  int x = 12;
  int y = 0;
  int res1;
  double res2;

  try {
    res1 = x ~/ y;
  } on UnsupportedError {
    print('Cannot divide by zero-0으로 나눌 수 없어요');
  }

  try {
    res2 = x / y;
  } on UnsupportedError catch(e) {
    print(e);
  }

  try {
    res2 = x / y;
  } catch(e) {
    print(e);
  }

  divide(x, y);
}
divide(int a, int b) {
  if (b == 0) {
    throw new Exception('Cannot divide by zero');
  }
  return a / b;
}