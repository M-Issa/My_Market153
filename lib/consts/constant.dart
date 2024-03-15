//sign out
import 'package:mansour7/modules/login/shop_login_screen.dart';
import 'package:mansour7/shared/components/components.dart';

import '../shared/local/cash_helper.dart';

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token='';
String pass='';