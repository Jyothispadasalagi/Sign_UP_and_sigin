import 'package:flutter/material.dart';

import '../signin.dart';
class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Material(
      child: Container(
        height: height/10,
        width: width,
        padding: EdgeInsets.only(left: 15, top: 25),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors:[Colors.white, Colors.white]
          ),
        ),
        child: Row(
          children: <Widget>[

            IconButton(
               icon: Icon(Icons.arrow_back,),
                onPressed: (){
                  print("pop");

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext ctx) => SignInPage()));
                 // Navigator.of(context).pop();
            }),
            //Image.asset("assets/images/download.png", fit: BoxFit.fill,height: 45),

          ],
        ),
      ),
    );
  }
}
