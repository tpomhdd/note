import 'package:flutter/material.dart';
import 'package:schoolnot/services/PrintService.dart';

class PrintScreen extends StatefulWidget {
  @override
  _PrintScreenState createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintScreen> {
  final GlobalKey _globalKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () => PrintService.printScreen(context, _globalKey),
        icon: Icon(
          Icons.print,
          color: Colors.black,
          size: 44,
        ),
      ),
      appBar: AppBar(title: Text("معاينة الطباعة")),
      body: RepaintBoundary(
        key: _globalKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "هذا محتوى الطباعة",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => PrintService.printScreen(context, _globalKey),
                child: Text("طباعة الشاشة"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
