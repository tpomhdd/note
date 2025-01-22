
import 'package:flutter/material.dart';
class MyTextField extends StatefulWidget {
final TextEditingController? controller;
final String text;
final bool? pass;
final Color mycolor;
const MyTextField({Key? key, this.controller,required  this.text,this.pass, required this.mycolor}) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
    child: Container(
decoration: BoxDecoration(
  border:Border.all(color: widget.mycolor,width: 1)
),
      //height: 150,
    child: TextFormField(
    controller: widget.controller,
      obscureText: widget.pass == null ||  widget.pass  == false  ? false : true,



      //  keyboardType: const TextInputType.numberWithOptions(decimal: true),
    decoration: InputDecoration(

    isDense: true,
    filled: true,//
   fillColor:widget.mycolor,
    hintText: widget.text,
    border: InputBorder.none,


    hintStyle:  TextStyle(
  //  color: mycolor.myhinttxt,
    fontSize: 20
    ),

    ),
    ),
    ),
      );
  }
}
