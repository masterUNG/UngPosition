import 'package:flutter/material.dart';
import 'package:ungposition/utility/my_constant.dart';

String title;

class TitleH1 extends StatelessWidget {
  TitleH1(String string) {
    title = string;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: MyConstant().dark,
      ),
    );
  }
}
