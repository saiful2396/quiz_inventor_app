import 'dart:io';

main(){
  print('What is your name?');
  var name = stdin.readLineSync();
  print('welcome back user: $name');
}