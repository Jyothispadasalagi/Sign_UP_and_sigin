import 'dart:convert';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/constants/constants.dart';
import 'package:login_signup/ui/signin.dart';
//import 'package:login_signup/modules/verify.dart';
import 'package:login_signup/ui/widgets/custom_shape.dart';
import 'package:login_signup/ui/widgets/customappbar.dart';
import 'package:login_signup/ui/widgets/responsive_ui.dart';
import 'package:login_signup/ui/widgets/textformfield.dart';
import 'package:http/http.dart' as http;
//import 'package:login_signup/utils/validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Welcome.dart';
//import '../DashBoard1.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool checkBoxValue = false;
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
      register();
    }
  }

  TextEditingController firstnamecontroller = TextEditingController();

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController secondnamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  Future register() async {

    //SharedPreferences prefs = await SharedPreferences.getInstance();
   // prefs.setString('mobilenumber', phonecontroller.text);

    var url = "http://192.168.24.230/project/register1.php";
    var response = await http.post(url, body: {
      "name": firstnamecontroller.text,
      "emailid": emailcontroller.text,
      "mobilenumber": phonecontroller.text,
      "address": secondnamecontroller.text,
      "password": passwordcontroller.text,
    });
    print(response.body);
    var data = json.decode(response.body);
    print(data);
    if (data == "Error") {
      Fluttertoast.showToast(
          msg: "already exists",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.pinkAccent[100],
          textColor: Colors.black,
          fontSize: 16.0
      );
    }
    else {
      Fluttertoast.showToast(
          msg: "Register successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.pinkAccent[100],
          textColor: Colors.black,
          fontSize: 16.0
      );

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext ctx) => DashBoardPage()));

    }
  }


  @override
  Widget build(BuildContext context) {
    _height = MediaQuery
        .of(context)
        .size
        .height;
    _width = MediaQuery
        .of(context)
        .size
        .width;
    _pixelRatio = MediaQuery
        .of(context)
        .devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Material(
      child: Scaffold(
        body: Container(
          height: _height,
          width: _width,
          margin: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Opacity(opacity: 0.88, child: CustomAppBar()),
                clipShape(),
                form(),
                //acceptTermsTextRow(),
                SizedBox(height: _height / 35,),
                button(),
                //infoTextRow(),
               // socialIconsRow(),
                signInTextRow(),
               // BottomImage(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large ? _height / 8 : (_medium ? _height / 7 : _height /
                  6.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[300], Colors.pinkAccent],
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
              height: _large ? _height / 12 : (_medium
                  ? _height / 11
                  : _height / 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[300], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),

//        Positioned(
//          top: _height/8,
//          left: _width/1.75,
//          child: Container(
//            alignment: Alignment.center,
//            height: _height/23,
//            padding: EdgeInsets.all(5),
//            decoration: BoxDecoration(
//              shape: BoxShape.circle,
//              color:  Colors.orange[100],
//            ),
//            child: GestureDetector(
//                onTap: (){
//                  print('Adding photo');
//                },
//                child: Icon(Icons.add_a_photo, size: _large? 22: (_medium? 15: 13),)),
//          ),
//        ),
      ],
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0,
          right: _width / 12.0,
          top: _height / 300.0),
      child: Form(
        key: _key,
        child: Column(
          children: <Widget>[
            firstNameTextFormField(),
            SizedBox(height: _height / 60.0),
            emailTextFormField(),
            SizedBox(height: _height / 60.0),
            phoneTextFormField(),
            SizedBox(height: _height / 60.0),
            lastNameTextFormField(),
            SizedBox(height: _height / 60.0),
            passwordTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget firstNameTextFormField() {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    medium=  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: large? 12 : (medium? 10 : 8),
      child: TextFormField(
      controller: firstnamecontroller,
      keyboardType: TextInputType.text,
        validator: (value)  {
          String pattern = r'(^[a-zA-Z ]*$)';
          RegExp regExp = new RegExp(pattern);
          if (value.length == 0) {
            return "Name is Required";
          } else if (!regExp.hasMatch(value)) {
            return "Name must be a-z and A-Z";
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
              child: Icon(Icons.person, color: Colors.orange[200],size: 20,),
            ),
            contentPadding: EdgeInsets.all(18),
            labelText: "First Name"),
    ),
    );
  }

  Widget lastNameTextFormField() {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    medium=  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: large? 12 : (medium? 10 : 8),
      child: TextFormField(
        controller: secondnamecontroller,
        keyboardType: TextInputType.text,
        validator: (value)  {
          String pattern = "";
          RegExp regExp = new RegExp(pattern);
          if (value.length == 0) {
            return "Address is Required";
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
              child: Icon(Icons.person, color: Colors.orange[200],size: 20,),
            ),
            contentPadding: EdgeInsets.all(18),
            labelText: "Address"),
      ),
    );
  }

  Widget emailTextFormField() {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    medium=  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: large? 12 : (medium? 10 : 8),
      child: TextFormField(
        controller: emailcontroller,
        keyboardType: TextInputType.text,
        validator: (value)  {
          String pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regExp = new RegExp(pattern);
          if (value.length == 0) {
            return "Email is Required";
          } else if (!regExp.hasMatch(value)) {
            return "Invalid Email";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 20, right: 15),
              child: Icon(Icons.email, color: Colors.orange[200],size: 20,),
            ),
            contentPadding: EdgeInsets.all(18),
            labelText: "Email ID"),
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

  Widget passwordTextFormField() {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    medium=  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: large? 12 : (medium? 10 : 8),
      child: TextFormField(
        controller: passwordcontroller,
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

  Widget button() {
    // ignore: deprecated_member_use
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      //onPressed: () {
        //print("Routing to your account");
        //Scaffold
          //  .of(context)
        // ignore: deprecated_member_use
            //.showSnackBar(SnackBar(content: Text('Login Successful')));
      //},
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
          //padding: const EdgeInsets.all(12.0),
          // ignore: deprecated_member_use
          child: RaisedButton(
            color: Colors.pinkAccent[100],
            child: Text('SignUp', style: TextStyle(fontSize: _large? 14: (_medium? 16: 12))),
            onPressed: () async {


             // Navigator.pushReplacement(context,
               //   MaterialPageRoute(builder: (BuildContext ctx) => Verifypage()));


              check();
              //register();
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoard()));
            },
          )
      ),
    );
  }

  Widget infoTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Or create using social media",
            style: TextStyle(fontWeight: FontWeight.w400,
                fontSize: _large ? 12 : (_medium ? 11 : 10)),
          ),
        ],
      ),
    );
  }


  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Already have an account?",
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                     MaterialPageRoute(builder: (BuildContext ctx) => SignInPage()));
             // Navigator.of(context).pop(SIGN_IN);
              print("Routing to Sign up screen");
            },
            child: Text(
              "Sign in",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.orange[200],
                  fontSize: 19),
            ),
          )
        ],
      ),
    );
  }



}