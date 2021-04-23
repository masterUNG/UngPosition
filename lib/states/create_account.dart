import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungposition/utility/dialog.dart';
import 'package:ungposition/utility/my_constant.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  double size;
  String gender, name, user, password;

  Container buildName() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => name = value.trim(),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.fingerprint),
          labelText: 'Name :',
        ),
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
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.lock_outline),
          labelText: 'Password :',
        ),
      ),
    );
  }

  Future<Null> checkUserAnCreateAccount() async {
    String path1 =
        '${MyConstant().domain}/ungposition/getUserWhereUser.php?isAdd=true&user=$user';
    await Dio().get(path1).then((value) async {
      print('value = $value');
      if (value.toString() != 'null') {
        normalDialog(context, 'User False ?', 'This User Dulucate');
      } else {
        String path2 =
            '${MyConstant().domain}/ungposition/insertData.php?isAdd=true&name=$name&gender=$gender&user=$user&password=$password';
        await Dio().get(path2).then((value) {
          if (value.toString() == 'true') {
            Navigator.pop(context);
          } else {
            normalDialog(context, 'Create Account False ?', 'Plese Try Again');
          }
        });
      }
    });
  }

  Container buildLogin() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          if ((name == null || name.isEmpty) ||
              (user?.isEmpty ?? true) ||
              (password?.isEmpty ?? true)) {
            normalDialog(context, 'Have Space ?', 'Please Fill Every Blank');
          } else if (gender?.isEmpty ?? true) {
            normalDialog(context, 'No Gender ?', 'Please Tap Male or Female');
          } else {
            checkUserAnCreateAccount();
          }
        },
        child: Text('Login'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: Center(
        child: Column(
          children: [
            // Container(child: ShowAccount()),
            buildName(),
            buildMale(),
            buildFeMale(),
            buildUser(),
            buildPassword(),
            buildLogin(),
          ],
        ),
      ),
    );
  }

  Container buildMale() {
    return Container(
      width: 250,
      child: RadioListTile(
        value: 'male',
        groupValue: gender,
        onChanged: (value) {
          setState(() {
            gender = value;
          });
        },
        title: Text('Male'),
      ),
    );
  }

  Container buildFeMale() {
    return Container(
      width: 250,
      child: RadioListTile(
        value: 'female',
        groupValue: gender,
        onChanged: (value) {
          setState(() {
            gender = value;
          });
        },
        title: Text('Female'),
      ),
    );
  }
}
