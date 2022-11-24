import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:flutter_courtapp/DashBoard1.dart';
//import 'package:login_signup/DashBoard1.dart';
import 'package:login_signup/constants/constants.dart';
import 'package:login_signup/ui/signup.dart';
import 'package:login_signup/ui/widgets/custom_shape.dart';
import 'package:login_signup/ui/widgets/responsive_ui.dart';
import 'package:login_signup/ui/widgets/textformfield.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Welcome.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: Colors.white,


          //Image.asset('assets/images/download.png', fit: BoxFit.fill,height: 45,),
        ),
        body: SignInScreen(
        ));
  }
}


class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  bool large;
  bool medium;

  final _key = new GlobalKey<FormState>();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;

    if (form.validate()) {
      userLogin();

    }
  }
  //TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  //TextEditingController cpassC = TextEditingController();
  String msg="";
  bool visible=false;


  Future userLogin() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('mobilenumber', phonecontroller.text);
   // String emailid = emailController.text;
    String password = passwordController.text;
    String mobilenumber=phonecontroller.text;

  //  SharedPreferences  preferences= await SharedPreferences.getInstance();
    //preferences.setString(emailid, emailController.text);

    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller

    //String cpassword=cpassC.text;

    // SERVER LOGIN API URL
    var url = 'http://192.168.24.230/project/login.php';

    // Store all data with Param Name.
    var data = {'mobilenumber':mobilenumber, 'password': password};

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));
    // Getting Server response into variable.
    var message = jsonDecode(response.body);
    // If the Response Message is Matched.
    if (message == 'Login Matched') {
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
        msg = "login successfull";
      });
     // await FlutterSession().set('token',emailController.text);
      Fluttertoast.showToast(
          msg: "login successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.pinkAccent[100],
          textColor: Colors.black,
          fontSize: 16.0
      );
      // Navigate to Profile Screen & Sending Email to Next Screen.
     // Navigator.push(
      //    context,
      //    MaterialPageRoute(
        //      builder: (context) => DashBoardPage())
     // );
     Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext ctx) => DashBoardPage()));

    } else {
      // If Email or Password did not Match
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });

      // Showing Alert Dialog with Response JSON Message.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
    @override
  Widget build(BuildContext context) {
   _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      child: Container(
        height: _height,
        width: _width,
        padding: EdgeInsets.only(bottom: 5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              clipShape(),
              welcomeTextRow(),
              signInTextRow(),
              form(),
              forgetPassTextRow(),
              SizedBox(height: _height / 70),
              button(),

              SizedBox(height: _height / 70),
              signUpTextRow(),
           //   BottomImage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    //double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height:_large? _height/14 : (_medium? _height/3.75 : _height/3.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[100], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large? _height/15.5 : (_medium? _height/4.25 : _height/4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[100], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }

  Widget welcomeTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 20, top: _height / 5550),
      child: Row(
        children: <Widget>[
          Text(
            "Welcome",
            style: TextStyle(
              // fontWeight: FontWeight.bold,
              fontSize: _large? 30 : (_medium? 40 : 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 15.0),
      child: Row(
        children: <Widget>[
          Text(
            "Sign in to your account",
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: _large? 20 : (_medium? 17.5 : 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0,
          right: _width / 12.0,
          top: _height / 15.0),
      child: Form(
        key: _key,
        child: Column(
          children: <Widget>[
            //emailTextFormField(),
            phoneTextFormField(),
            SizedBox(height: _height / 40.0),
            passwordTextFormField(),
          ],
        ),
      ),
    );
  }


  Widget passwordTextFormField() {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    medium=  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: large? 12 : (medium? 10 : 8),
      child: TextFormField(
        controller: passwordController,
        keyboardType: TextInputType.text,
        validator: (value)  {
          if(value.length==0){
            return "Password can't be empty";
          } else if (value.length < 10){
            return "Password must be longer than 10 characters";
          }
          return null;
        },
        obscureText: _secureText,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 20, right: 15),
              child: Icon(Icons.lock, color: Colors.orange[200],size: 20,),
            ),
            suffixIcon: IconButton(
              onPressed: showHide,
              icon: Icon(_secureText
                  ? Icons.visibility_off
                  : Icons.visibility),
            ),
            contentPadding: EdgeInsets.all(18),
            labelText: "Password"),
      ),
    );
  }

  Widget phoneTextFormField() {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    medium=  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: large? 12 : (medium? 10 : 8),
      child: TextFormField(
        controller: phonecontroller,
        keyboardType: TextInputType.text,
        validator: (value)  {
          String pattern = r'(^[0-9]*$)';
          RegExp regExp = new RegExp(pattern);
          if (value.length == 0) {
            return "Mobile is Required";
          } else if (value.length != 10) {
            return "Mobile number must 10 digits";
          } else if (!regExp.hasMatch(value)) {
            return "Mobile Number must be digits";
          }
          return null;
        },
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 20, right: 15),
              child: Icon(Icons.phone, color: Colors.orange[200],size: 20,),
            ),
            contentPadding: EdgeInsets.all(18),
            labelText: "Mobile Number"),
      ),
    );
  }

  Widget forgetPassTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Forgot your password?",
            style: TextStyle(fontWeight: FontWeight.w400,fontSize: _large? 14: (_medium? 12: 10)),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              print("Routing");
            },
            child: Text(
              "Recover",
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.orange[200]),
            ),
          )
        ],
      ),
    );
  }

  Widget button() {
    // ignore: deprecated_member_use
    return RaisedButton(

      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
        print("Routing to your account");
        //Scaffold
          //  .of(context)
            // ignore: deprecated_member_use
            //.showSnackBar(SnackBar(content: Text('Login Successful')));
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        width: _large? _width/4 : (_medium? _width/3.75: _width/3.5),
       decoration: BoxDecoration(
         borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[Colors.pinkAccent[100], Colors.pinkAccent[100]],
          ),
        ),
       // padding: const EdgeInsets.all(12.0),
          // ignore: deprecated_member_use
          child: RaisedButton(

            color: Colors.pinkAccent[100],
            child: Text('SignIn',
                style: TextStyle(fontSize: _large? 20: (_medium? 16: 12))),
            onPressed: () async {
              //after the login REST api call && response code ==200

              //SharedPreferences prefs = await SharedPreferences.getInstance();
              //prefs.setString('mobilenumber', phonecontroller.text);
              check();


            },
          )
      ),
    );
  }

  Widget signUpTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 120.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Don't have an account?",
            style: TextStyle(fontWeight: FontWeight.w400,
                fontSize: _large ? 14 : (_medium ? 12 : 10)),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
             // Navigator.of(context).pushNamed(SIGN_UP);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext ctx) => SignUpScreen()));
              // Navigator.of(context).pop(SIGN_IN);

              print("Routing to Sign up screen");
            },
            child: Text(
              "Sign up",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.orange[200],
                  fontSize: _large ? 19 : (_medium ? 17 : 15)),
            ),
          ),],
      ),);
  }

  Widget BottomImage() {
    return Container(
      margin: EdgeInsets.only(top: _height / 220.0),
      child: Row(

       mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 40),
          Image.asset(
            "assets/images/nicc.png",
            height:100,
            width: 70,

            alignment: Alignment.bottomRight,

          ),

         ],
      ),);
  }












}
