//import 'dart:html';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/gestures.dart';

import 'package:platform_date_picker/platform_date_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'navdrawer.dart';

class DashBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          toolbarHeight: 50,
          backgroundColor: Colors.white,
          //title: Image.asset('assets/images/download.png', fit: BoxFit.fill,height: 45,),
          elevation: 0.9,
          actions: <Widget>[
          ],
        ),
        body: DashboardScreen()
    );
  }
}
class DashboardScreen extends StatefulWidget {
  @override
  DashBoardState createState() => DashBoardState();
}
class DashBoardState extends State<DashboardScreen> {




  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cardtextstyle = TextStyle(fontSize: 14,color: Color.fromRGBO(63, 63, 63, 1));
    return Scaffold(
      body:Stack(
        children: <Widget>[
          Container(

            height: size.height * .3,
            decoration: BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage('assets/img/topheader.png')
                )
            ),
          ),
          SafeArea(child:Padding(
            padding: EdgeInsets.all(16.0),
            child:Column(
              children: <Widget>[
                Container(
                  height: 64,
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //CircleAvatar(                      //),
                      SizedBox(width: 16,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:<Widget>[
                          //Text('HCK Case management',style: TextStyle(fontSize: 27,color: Colors.white,fontWeight: FontWeight.bold),),
                        ],
                      ),


                    ],


                  ),
                ),



                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: <Widget>[
                    Text('WELCOME TO NEW PROJECT',style: TextStyle(fontSize: 27,color: Colors.pinkAccent,fontWeight: FontWeight.bold),),


                  ],

                )



              ],
            ),
          ),
          ),
        ],
      ) ,
    );
  }

}