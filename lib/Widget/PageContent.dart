import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:schoolnot/Screen/BarcodeSlider.dart';


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolnot/Screen/BarcodeSlider.dart';
import 'package:schoolnot/Screen/NotebookScreenPage.dart';
import 'package:schoolnot/Screen/nullpage.dart';
import 'package:schoolnot/Screen/testbarcode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'package:schoolnot/Widget/man_widget/mytext.dart';
import 'package:turn_page_transition/turn_page_transition.dart';

import '../Widget/CustomDrawer.dart';
import '../services/PrintService.dart';
import '../services/SubjectService.dart';



class PageContent extends StatefulWidget {
  final String title;
  final  String content;
  final String id;
  final String idnot;
  final int pages;

  PageContent({required this.title, required this.id, required this.content, required this.idnot, required this.pages});

  @override
  _PageContentState createState() => _PageContentState();
}

class _PageContentState extends State<PageContent> {
  final GlobalKey _globalKey = GlobalKey();
  List<Map<String, dynamic>> assignments = [];

  @override
  void initState() {
    super.initState();
    fetchAssignments();
    _loadPageNumber(); // تحميل رقم الصفحة عند بدء التطبيق
  }
  int _currentPage = 0;



  Future<void> _loadPageNumber() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentPage = prefs.getInt('current_page_${widget.id}') ?? 0; // افتراضيًا 0
    });
  }

  Future<void> _updateAndSavePageNumber() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentPage++; // زيادة العداد بمقدار 1
    });
    await prefs.setInt('current_page_${widget.id}', _currentPage); // حفظ العداد الجديد
  }

  void _nextPage() {
    if (_currentPage < widget.pages - 1) {
      _updateAndSavePageNumber(); // حفظ وزيادة العداد
      Navigator.of(context).push(
        TurnPageRoute(
          overleafColor: Colors.white,
          transitionDuration: Duration(milliseconds: 600),
          builder: (context) => PageContent(
            pages: widget.pages,
            id: widget.id, title: '', content: 'الصفحة ${widget.pages}', idnot: widget.idnot,
          ),
        ),
      );
    }
  }

  void _previousPage() async {
    if (_currentPage > 0) {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _currentPage--; // تقليل العداد بمقدار 1
      });
      await prefs.setInt('current_page_${widget.id}', _currentPage); // حفظ العداد الجديد
      Navigator.of(context).pop();
    }
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

    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _previousPage,
            icon: Icon(Icons.arrow_back_ios),
          ),
          IconButton(
            onPressed: _nextPage,
            icon: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),

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

              // قائمة البيانات من API
              Positioned(
                left: 2,
                bottom: 2,

                child:

//                assignment['page']==widget.content?
 SizedBox()             ),

              // مكان الباركود


            ],
          ),
        ),
      ),

    );
  }

}