import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:schoolnot/services/myclient.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controller/GradesController.dart';
import '../Controller/ImageUploadController.dart';
import '../Widget/man_widget/mytext.dart';
import 'index2.dart';

class update_notebook extends StatefulWidget {
  final String id;
  const update_notebook({required this.id});

  @override
  _update_notebookState createState() => _update_notebookState();
}

class _update_notebookState extends State<update_notebook> {
  final ImageUploadController _controller = ImageUploadController();
  final GradesController _gradesController = GradesController();
  final GradesController2 _gradesController2 = GradesController2();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sectionController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _pageController = TextEditingController();

  bool _isUploading = false;
  List<dynamic> grades = [];
  String? selectedGrade;
  List<dynamic> subjects = [];

  List<dynamic> grades2 = [];
  String? pagetype;
  String? type;
  String? selectedGrade2;

  Future<void> loadGrades() async {
    final fetchedGrades = await _gradesController.fetchGrades();
    setState(() {
      grades = fetchedGrades;
    });
  }

  Future<void> loadGrades2() async {
    final fetchedGrades2 = await _gradesController2.fetchGrades();
    setState(() {
      grades2 = fetchedGrades2;
    });
  }

  String? selectedSubject;

  Future<void> loadSubjects() async {
    try {
      final List<dynamic> fetchedSubjects = await _gradesController.fetchSubjects();
      setState(() {
        subjects = fetchedSubjects;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء تحميل المواد')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    loadSubjects();
    loadGrades();
    loadGrades2();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
                onTap: () {
                  Get.to(teacher());
                },
                child: MyText(
                    color: Colors.white,
                    text: 'العودة للصفحة الرئيسية',
                    size: 15))
          ],

        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.lightBlue.shade100,
                Colors.indigo.shade200,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Text(
                  'تعديل الدفتر',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.amberAccent,
                  ),
                ),
                SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  value: selectedSubject,
                  decoration: InputDecoration(
                    labelText: 'اختر المادة',
                    labelStyle: TextStyle(color: Colors.amberAccent),
                    filled: true,
                    fillColor: Colors.amberAccent.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  dropdownColor: Colors.indigo.shade100,
                  hint: Text(
                    'اختر مادة',
                    style: TextStyle(color: Colors.amberAccent),
                  ),
                  items: subjects.map((subject) {
                    return DropdownMenuItem<String>(
                      value: subject['id'].toString(),
                      child: Text(
                        subject['name'],
                        style: TextStyle(color: Colors.indigo.shade800),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSubject = value;
                    });
                  },
                ),
                SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  value: selectedGrade,
                  decoration: InputDecoration(
                    labelText: 'اختر الصف',
                    labelStyle: TextStyle(color: Colors.amberAccent),
                    filled: true,
                    fillColor: Colors.amberAccent.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  dropdownColor: Colors.indigo.shade100,
                  hint: Text(
                    'اختر صفًا',
                    style: TextStyle(color: Colors.amberAccent),
                  ),
                  items: grades.map((grade) {
                    return DropdownMenuItem<String>(
                      value: grade['id'].toString(),
                      child: Text(
                        grade['name'],
                        style: TextStyle(color: Colors.indigo.shade800),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedGrade = value;
                    });
                  },
                ),
                SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  value: selectedGrade2,
                  decoration: InputDecoration(
                    labelText: 'اختر الشعبة',
                    labelStyle: TextStyle(color: Colors.amberAccent),
                    filled: true,
                    fillColor: Colors.amberAccent.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  dropdownColor: Colors.indigo.shade100,
                  hint: Text(
                    'اختر الشعبة',
                    style: TextStyle(color: Colors.amberAccent),
                  ),
                  items: grades2.map((grade) {
                    return DropdownMenuItem<String>(
                      value: grade['id'].toString(),
                      child: Text(
                        grade['name'],
                        style: TextStyle(color: Colors.indigo.shade800),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedGrade2 = value;
                    });
                  },
                ),
                SizedBox(height: 30),
                Center(
                  child: _isUploading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 32.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: () {
                      myclient().update_notebook(
                        selectedGrade.toString(),
                        selectedGrade2.toString(),
                        'course',
                        selectedSubject.toString(),
                        widget.id,
                      );
                    },
                    child: Text(
                      'تعديل الدفتر',
                      style: TextStyle(fontSize: 18, color: Colors.amberAccent),
                    ),
                  ),
                ),
SizedBox(height: 500,)              ],
            ),
          ),
        ),
      ),
    );
  }
}
