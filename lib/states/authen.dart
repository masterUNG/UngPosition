import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungposition/models/user_model.dart';
import 'package:ungposition/utility/dialog.dart';
import 'package:ungposition/utility/my_constant.dart';
import 'package:ungposition/widget/show_logo.dart';
import 'package:ungposition/widget/title_h1.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool redEye = true;
  String user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildAdd(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildLogo(),
            TitleH1(MyConstant().appName),
            buildUser(),
            buildPassword(),
            buildLogin(),
          ],
        ),
      ),
    );
  }

  FloatingActionButton buildAdd() {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, '/createAccount'),
      child: Text('Add'),
    );
  }

  Container buildLogin() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
            normalDialog(context, 'มีช่องว่าง ?', 'กรุณากรอง ทุกช่องสิคะ !!');
          } else {
            cheackAuthen();
          }
        },
        child: Text('Login'),
      ),
    );
  }

  Container buildUser() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => user = value.trim(),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.perm_identity),
          labelText: 'User :',
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: redEye,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.lock_outline),
          labelText: 'Password :',
          suffixIcon: IconButton(
            icon: Icon(Icons.remove_red_eye),
            onPressed: () {
              setState(() {
                redEye = !redEye;
              });
            },
          ),
        ),
      ),
    );
  }

  Container buildLogo() {
    return Container(
      width: 120,
      child: ShowLogo(),
    );
  }

  Future<Null> cheackAuthen() async {
    String path =
        '${MyConstant().domain}/ungposition/getUserWhereUser.php?isAdd=true&user=$user';
    await Dio().get(path).then((value) async {
      if (value.toString() == 'null') {
        normalDialog(context, 'User False !!!', 'No $user in my Database');
      } else {
        print('value ---> $value');
        for (var item in json.decode(value.data)) {
          print('item ===> $item');
          UserModel model = UserModel.fromMap(item);
          if (password == model.password) {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.setString('id', model.id);
            preferences.setString('user', model.user);
            preferences.setString('name', model.name);

            Navigator.pushNamedAndRemoveUntil(
                context, '/myService', (route) => false);
          } else {
            normalDialog(context, 'Password False ?',
                'Please Try Again !! Password False');
          }
        }
      }
    });
  }
}
