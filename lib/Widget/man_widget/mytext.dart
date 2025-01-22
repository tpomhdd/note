import 'package:flutter/material.dart';
class MyText extends StatefulWidget {
final String text;
final Color color;
final FontWeight? fontWeight;
final double size;
  const MyText({Key? key,required this.color,required this.text,required this.size,this.fontWeight, }) : super(key: key);

  @override
  State<MyText> createState() => _MyTextState();
}

class _MyTextState extends State<MyText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(widget.text,style: TextStyle(color: widget.color,fontSize: widget.size
       ,fontWeight: widget.fontWeight),textAlign: TextAlign.center,),
    );
  }
}
