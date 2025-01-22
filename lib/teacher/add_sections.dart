//add_sections
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:schoolnot/Widget/man_widget/mytext.dart';
import 'dart:convert';

import 'package:schoolnot/services/myclient.dart';
import 'package:schoolnot/teacher/index2.dart';

import '../Controller/GradesController.dart';

class add_sections extends StatefulWidget {
final String idclass;

  const add_sections({super.key, required this.idclass});

@override
  _add_sectionsState createState() => _add_sectionsState();
}

class _add_sectionsState extends State<add_sections> {
  final TextEditingController barcodeController = TextEditingController();
  final GradesController _gradesController = GradesController(); // كنترولر الصفوف
  final GradesController2 _gradesController2 = GradesController2(); // كنترولر الصفوف

  final TextEditingController typeController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final TextEditingController classidController = TextEditingController();
  final TextEditingController sectionidController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  List<dynamic> grades = []; // قائمة الصفوف
  String? selectedGrade; // الصف المختار
  List<dynamic> subjects = []; // قائمة المواد


  List<dynamic> grades2 = []; // قائمة الصفوف
  String? pagetype;
  String? type;
  String? selectedGrade2; // الصف المختار
  // جلب البيانات من API عبر الكنترولر
  Future<void> loadGrades() async {
    final fetchedGrades = await _gradesController.fetchGrades();
    setState(() {
      grades = fetchedGrades; // تخزين البيانات
    });
  }

  // جلب البيانات من API عبر الكنترولر
  Future<void> loadGrades2() async {
    final fetchedGrades2 = await _gradesController2.fetchGrades();
    setState(() {
      grades2 = fetchedGrades2; // تخزين البيانات
    });
  }
  String? selectedSubject; // المادة المختارة

  // جلب المواد من API
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
  void initState() {
    super.initState();
    loadSubjects();
    loadGrades(); // جلب البيانات عند تشغيل الصفحة
    loadGrades2();
  }



  Future<void> sendData() async {
    final String apiUrl = "https://tpowep.com/notschoolapi/add_content.php";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "barcode": barcodeController.text,
          "type": typeController.text,
          "url": urlController.text,
          "classid": int.tryParse(classidController.text) ?? 0,
          "sectionid": int.tryParse(sectionidController.text) ?? 0,
          "subject_id": int.tryParse(subjectController.text) ?? 0,
        }),
      );

      // تحقق مما إذا كانت الاستجابة فارغة
      if (response.body.isEmpty) {
        throw Exception("الخادم لم يرجع أي بيانات.");
      }

      // التحقق مما إذا كانت الاستجابة HTML بدلاً من JSON
      if (response.body.startsWith("<!DOCTYPE html>")) {
        throw Exception("الخادم أعاد صفحة HTML بدلاً من JSON.");
      }
      print(response.body);
      final responseData = jsonDecode(response.body);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(responseData['message'] ?? 'تم الإرسال بنجاح')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("خطأ: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("إضافة الشعبة"), backgroundColor: Colors.blueAccent,
      actions: [
        InkWell(
            onTap: (){
              Get.to(teacher());
            },
            child: MyText(color: Colors.white, text: 'العودة للصفحة الرئيسية', size: 15))
      ],),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField(barcodeController, "الاسم"),



            SizedBox(height: 15),

            ElevatedButton(
              onPressed: (){
                myclient().add_sections(barcodeController.text, 'thetetcher',widget.idclass);
                Get.snackbar('تمت الاضافة', "تمت الاضافة",backgroundColor: Colors.black,colorText: Colors.white);

              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text("إرسال البيانات", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }
}
