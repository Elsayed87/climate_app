import 'dart:io';
late int a, b, z;
late double c;
void main() {
  preformTasks();
}
void preformTasks() async {
  await task1();
  task2();
  task3();
}
Future<int> task1() async {
  a = 25;
  b = 20;
  Duration threeSecond = Duration(seconds: 5);
  await Future.delayed(threeSecond, () {
    z = (a + b);
    print('task1 done $z');
  });
  return z;
}
void task2() {
  c = 2;
  print(c + 1);
}
void task3() {
  print(c);
}
