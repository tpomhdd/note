
import 'package:flutter/material.dart';

//import 'package:hexcolor/hexcolor.dart';

class ThemeHelper{
  static TextStyle myTextwh25=TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white,);
  static TextStyle myTextred18=TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.deepOrange);

  static TextStyle myTextblk16=TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black);
  static TextStyle myTextWhite14=TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white);


  static BoxDecoration BKblack_OP= BoxDecoration(


    color:Colors.black.withOpacity(0.6),
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10)
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3),

      )],);

//
  static Color myColor=Color(0xFFa62049);

  static BoxDecoration bkwhite= BoxDecoration(


    color:Colors.white.withOpacity(0.5),
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10)
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.white.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3),

       )],);

  static BoxDecoration bkcard= BoxDecoration(


    color:Colors.white.withOpacity(0.5),
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10)
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.white.withOpacity(0.5),
        spreadRadius: 1,
        blurRadius: 1,
        offset: Offset(0, 3),

      )],
  );
  static BoxDecoration BKblack_nowh= BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(22)
  );

  static BoxDecoration mycircular= BoxDecoration(
//color: Colors.blueAccent,
      borderRadius: BorderRadius.circular(30));
  static BoxDecoration BKblack_wh= BoxDecoration(


   // color:Colors.black.withOpacity(0.6),
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10)
    ),
    boxShadow: [
      BoxShadow(
    //    color: Colors.grey.withOpacity(0.5),
         spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3),

      )],);


  static BoxDecoration BK_Goals= BoxDecoration(
      color:  myColor,
      borderRadius: BorderRadius.circular(22));


  InputDecoration textInputDecoration([String lableText="", String hintText = ""]){
    return InputDecoration(
      labelText: lableText,
      hintText: hintText,
      fillColor: Colors.white,
      filled: true,
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey.shade400)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
    );
  }

  BoxDecoration inputBoxDecorationShaddow() {
    return BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 20,
        offset: const Offset(0, 5),
      )
    ]);
  }

  BoxDecoration buttonBoxDecoration(BuildContext context, [String color1 = "", String color2 = ""]) {
    Color c1 = Theme.of(context).primaryColor;
    Color c2 = Theme.of(context).accentColor;
    if (color1.isEmpty == false) {
      c1 = Colors.pinkAccent;
    }
    if (color2.isEmpty == false) {
      c2 = Colors.pinkAccent;
    }

    return BoxDecoration(
      boxShadow: [
        BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
      ],
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 1.0],
        colors: [
          c1,
          c2,
        ],
      ),
      color: Colors.deepPurple.shade300,
      borderRadius: BorderRadius.circular(30),
    );
  }
  BoxDecoration myBoxDecoration(BuildContext context, Color c1,Color c2) {

    return BoxDecoration(
      boxShadow: [
        BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
      ],
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 1.0],
        colors: [
          c1,
          c2,
        ],
      ),
      color: Colors.deepPurple.shade300,
      borderRadius: BorderRadius.circular(30),
    );
  }
  BoxDecoration ContainerDecorationSlider(BuildContext context, [String color1 = "", String color2 = ""]) {
    Color c1 = Colors.white;
    Color c2 = Colors.white;
    if (color1.isEmpty == false) {
      c1 = Colors.pinkAccent;
    }
    if (color2.isEmpty == false) {
      c2 = Colors.pinkAccent;
    }

    return BoxDecoration(
      boxShadow: [
        BoxShadow(color: Colors.black26, offset: Offset(3, 3), blurRadius: 3.0)
      ],
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 1.0],
        colors: [
          c1,
          c2,
        ],
      ),
      color: Colors.deepPurple.shade300,
      borderRadius: BorderRadius.circular(10),
    );
  }

  BoxDecoration ContainerDecorationSlider2(BuildContext context, [String color1 = "", String color2 = ""]) {
    Color c1 = Colors.white;
    Color c2 = Colors.white;
    if (color1.isEmpty == false) {
      c1 = Colors.pinkAccent;
    }
    if (color2.isEmpty == false) {
      c2 = Colors.pinkAccent;
    }

    return BoxDecoration(

      
//      color: Colors.deepPurple.shade300,
      borderRadius: BorderRadius.circular(50),
    );
  }


  BoxDecoration ContainerDecoration(BuildContext context, [String color1 = "", String color2 = ""]) {
    Color c1 = Colors.white;
    Color c2 = Colors.white;
    if (color1.isEmpty == false) {
      c1 = Colors.pinkAccent;
    }
    if (color2.isEmpty == false) {
      c2 = Colors.pinkAccent;
    }

    return BoxDecoration(
      boxShadow: [
        BoxShadow(color: Colors.black26, offset: Offset(5, 4), blurRadius: 5.0)
      ],
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 1.0],
        colors: [
          c1,
          c2,
        ],
      ),
      color: Colors.deepPurple.shade300,
      borderRadius: BorderRadius.circular(30),
    );
  }


  ButtonStyle buttonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      minimumSize: MaterialStateProperty.all(Size(50, 50)),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
    );
  }

  AlertDialog alartDialog(String title, String content, BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black38)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

}

class LoginFormStyle{

}
