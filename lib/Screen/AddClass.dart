import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:schoolnot/Screen/BarcodeSlider.dart';
import 'package:schoolnot/services/myclient.dart';

class AddClass extends StatefulWidget {
  @override
  _AddClassState createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {

  final nameController = TextEditingController();





  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(

        body:  Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade100, Colors.blueAccent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child:  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  style: TextStyle(color: Colors.white), // تغيير لون النص المدخل من قبل المستخدم
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'الصف',
                    labelStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(Icons.person, color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  validator: (value) =>
                  value!.isEmpty ? 'الرجاء إدخال الاسم الكامل' : null,
                ),

                SizedBox(height: 16),

                ElevatedButton(

                  onPressed: () {

                    myclient().The_teacher(nameController.text);
Get.defaultDialog(
  title: 'تمت الاضافة',

) ;                 },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Text(
                    'إنشاء صف',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
