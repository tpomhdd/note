import 'package:flutter/material.dart';

class MyImg extends StatefulWidget {
  final  double width;
  final double height;
  final String url;
  const MyImg({Key? key,required this.width,required this.height, required this.url}) : super(key: key);

  @override
  State<MyImg> createState() => _MyImgState();
}

class _MyImgState extends State<MyImg> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(widget.url,
        width:widget.width ,
        height: widget.height,),
    );
  }
}
