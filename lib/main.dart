import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungposition/states/authen.dart';
import 'package:ungposition/states/create_account.dart';
import 'package:ungposition/states/my_service.dart';
import 'package:ungposition/states/show_detail.dart';
import 'package:ungposition/states/update_location.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/myService': (BuildContext context) => MyService(),
  '/updateLocation': (BuildContext context) => UpdateLocotion(),
  '/showDetail': (BuildContext context) => ShowDetail(),
};

String initialRoute;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String user = preferences.getString('user');
  if (user?.isEmpty ?? true) {
    initialRoute = '/authen';
    runApp(MyApp());
  } else {
    initialRoute = '/myService';
    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: map,
      initialRoute: initialRoute,
    );
  }
}
