import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:flutter/material.dart';

import '../Screen/nullpage.dart';
import '../Screen/testbarcode.dart';
import 'man_widget/mytext.dart';
class assigment_qr extends StatefulWidget {
 final String idnot;
 final String title;
 final  String content;
 final String id;

 final int pages;

 const assigment_qr({Key? key, required this.idnot, required this.title, required this.content, required this.id, required this.pages}) : super(key: key);

  @override
  State<assigment_qr> createState() => _assigment_qrState();
}

class _assigment_qrState extends State<assigment_qr> {
  List<Map<String, dynamic>> assignments = [];

  @override
  void initState() {
    super.initState();
    fetchAssignments();

  }
  Future<void> fetchAssignments() async {
    try {
      final response =
      await http.get(Uri.parse('https://schoolnot.tpowep.com/getAssignmentall?notebook=${widget.idnot}'));
      print('https://schoolnot.tpowep.com/getAssignmentall?notebook=${widget.idnot}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          assignments = List<Map<String, dynamic>>.from(data['Assignment']);
        });
      } else {
        throw Exception('❌ فشل جلب البيانات');
      }
    } catch (e) {
      print('🚨 خطأ أثناء جلب البيانات: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (assignments.isEmpty) {
      return SizedBox();}

    int page=widget.pages;
    // تحويل `widget.content` إلى رقم بأمان
    int index = page;
    try {
      index = page-1;
      if (index < 0 || index >= assignments.length) {
        throw RangeError("Invalid index");
      }
    } catch (e) {
      print("🚨 خطأ: فهرس غير صالح: $e");
      return SizedBox();    }

    final assignment = assignments[index];
    return                Column(

      children: [
        SizedBox(height: 25,),

        Container(

          child: BarcodePage(
            url: assignment['file_path'],
            address: assignment['assignment_name'] ?? 'بدون اسم',
          ),
        ),
        MyText(color: Colors.black, text: assignment['description'] ?? 'بدون وصف', size: 14),

      ],
    );
  }
}
