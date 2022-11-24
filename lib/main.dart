import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_signup/ui/signin.dart';

import 'constants/constants.dart';
//void main() => runApp(MyApp());
//void main() async {
//  WidgetsFlutterBinding.ensureInitialized();
 // SharedPreferences prefs = await SharedPreferences.getInstance();
 // var mobilenumber = prefs.getString('mobilenumber');
 // print(mobilenumber);
 // runApp(MaterialApp(home: mobilenumber == null ? MyApp() : DashBoardPage()));
//}



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.teal,
      ),
      home: SignInPage(),
    );
  }
}
