import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:login_signup/ui/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NavDrawer extends StatefulWidget{
  NavDrawer({Key key}) : super(key: key);
  @override
  NavDrawerState createState() => NavDrawerState();
}

class NavDrawerState extends State<NavDrawer>{


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0.5),
        children: <Widget>[
          DrawerHeader(
            // child: Text(
            // 'Case Management',
            //style: TextStyle(color: Colors.white, fontSize: 25),
            //),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[300], Colors.pinkAccent],
              ),
              //image: DecorationImage(
              //    fit: BoxFit.fitHeight,
              //      image: AssetImage('assets/images/karnataka.png'),
              //    )
            ),


          ),
          ListTile(

            title: Text('My Portal'),
            onTap: () => {

            },
          ),





          ListTile(
            enabled: true,
            leading: Image.asset('assets/img/logout.png',height: 40,width: 40),
            title: Text('Logout'),
            onTap: ()
            async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('mobilenumber');
              //var emailid = prefs.getString('emailid');
              //runApp(MaterialApp(home: emailid == null ? MyApp() : SignInPage()));
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext ctx) => SignInPage()));
            },
          ),
        ],
      ),
    );
  }
}






