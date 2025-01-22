import 'package:flutter/material.dart';

import '../Widget/man_widget/mytext.dart';
import '../services/PrintService.dart';
import 'BarcodeSlider.dart';
class nullpage extends StatefulWidget {

  const nullpage({Key? key}) : super(key: key);

  @override
  State<nullpage> createState() => _nullpageState();
}

class _nullpageState extends State<nullpage> {
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        child: Text("العودة إلى الصفحة الرئيسية"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => PrintService.printScreen(context, _globalKey),
        child: Icon(Icons.print, size: 25),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: RepaintBoundary(
        key: _globalKey,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(16),
          child: Stack(
            children: [
              // خلفية الصفحة المسطرة
              SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    100,
                        (index) => Container(
                      height: 24,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(child: MyText(color: Colors.black, text: 'صفحة فارغة', size: 24)),




            ],
          ),
        ),
      ),
    );
  }
}
