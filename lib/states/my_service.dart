import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungposition/widget/about_me.dart';
import 'package:ungposition/widget/list_friend.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  Widget current = ListFriend();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome '),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            buildSignOut(),
            Column(
              children: [
                buildUserAccountsDrawerHeader(),
                buildMenuListFriend(),
                buildMenuAboutMe(),
              ],
            ),
          ],
        ),
      ),body: current,
    );
  }

  ListTile buildMenuListFriend() {
    return ListTile(
      leading: Icon(Icons.filter_1),
      title: Text('List Friend'),
      subtitle: Text('แสดงรายชื่อ และ ตำแหน่งเพื่อนของเรา'),
      onTap: () {
        setState(() {
          current = ListFriend();
        });
        Navigator.pop(context);
      },
    );
  }

  ListTile buildMenuAboutMe() {
    return ListTile(
      leading: Icon(Icons.filter_2),
      title: Text('About Me'),
      subtitle: Text('Show Information'),
      onTap: () {
        setState(() {
          current = AboutMe();
        });
        Navigator.pop(context);
      },
    );
  }

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      accountName: null,
      accountEmail: null,
    );
  }

  Column buildSignOut() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          onTap: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.clear().then(
                  (value) => Navigator.pushNamed(context, '/authen'),
                );
          },
          leading: Icon(
            Icons.exit_to_app,
            color: Colors.white,
          ),
          title: Text(
            'Sign Out',
            style: TextStyle(color: Colors.white),
          ),
          tileColor: Colors.red.shade700,
        ),
      ],
    );
  }
}
