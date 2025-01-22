import 'package:flutter/material.dart';

class Logo_App extends StatefulWidget {
final  double width;
final double height;
  const Logo_App({Key? key,required this.width,required this.height}) : super(key: key);

  @override
  State<Logo_App> createState() => _Logo_AppState();
}

class _Logo_AppState extends State<Logo_App> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset("IMG/logo.png",
        width:widget.width ,
      height: widget.height,),
    );
  }
}
