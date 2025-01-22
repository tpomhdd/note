import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:schoolnot/services/myclient.dart';

import '../Controller/GradesController.dart';

class AddContentScreen extends StatefulWidget {
  @override
  _AddContentScreenState createState() => _AddContentScreenState();
}

class _AddContentScreenState extends State<AddContentScreen> {
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
  String? selectedTyp; // القيمة المختارة من القائمة
  final List<String> items = ['video', 'audio', 'image', 'activity'];


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
          "type": selectedTyp.toString(),
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
      print(selectedTyp.toString());
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
      appBar: AppBar(title: Text("إضافة محتوى"), backgroundColor: Colors.blueAccent),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(barcodeController, "عنوان المحتوى"),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'نوع المحتوى',
                labelStyle: TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.amber.withOpacity(0.9),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.white54, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
              ),


              value: selectedTyp,
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedTyp = value;
                  print('object'+selectedTyp.toString());
                });
              },
            ),    _buildTextField(urlController, "رابط المحتوى"),

            DropdownButtonFormField<String>(
              value: selectedSubject,
              decoration: InputDecoration(
                labelText: 'اختر المادة',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.amber.withOpacity(0.9),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.white54, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
              ),
              dropdownColor: Colors.blue.shade100,
              hint: Text(
                'اختر مادة',
                style: TextStyle(color: Colors.white),
              ),
              items: subjects.map((subject) {
                return DropdownMenuItem<String>(
                  value: subject['id'].toString(),
                  child: Text(
                    subject['name'],
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSubject = value;
                });
              },
            ),
            DropdownButtonFormField<String>(

              decoration: InputDecoration(
                labelText: 'اختر المادة',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.amber.withOpacity(0.9),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.white54, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
              ),
              dropdownColor: Colors.blue.shade100,
              hint: Text(
                'اختر مادة',
                style: TextStyle(color: Colors.white),
              ),
    value: selectedTyp,
    items: items.map((String item) {
      return DropdownMenuItem<String>(
        value: item,
        child: Text(item),
      );
    }
    ).toList(),
              onChanged: (value) {
                setState(() {
                  selectedTyp = value;
                });
              },
            ),
            SizedBox(height: 15),

            DropdownButtonFormField<String>(
              value: selectedGrade,
              decoration: InputDecoration(
                labelText: 'اختر الصف',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.blue.withOpacity(0.8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.white54, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
              ),
              dropdownColor: Colors.blue.shade100,
              hint: Text(
                'اختر صفًا',
                style: TextStyle(color: Colors.white),
              ),
              items: grades.map((grade) {
                return DropdownMenuItem<String>(
                  value: grade['id'].toString(),
                  child: Text(
                    grade['name'],
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedGrade = value.toString();
                });
              },
            ),
            SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: selectedGrade2,
              decoration: InputDecoration(
                labelText: 'اختر الصف',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.deepOrange.withOpacity(0.8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.white54, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
              ),
              dropdownColor: Colors.blue.shade100,
              hint: Text(
                'اختر الشعبة',
                style: TextStyle(color: Colors.white),
              ),
              items: grades2.map((grade) {
                return DropdownMenuItem<String>(
                  value: grade['id'].toString(),
                  child: Text(
                    grade['name'],
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedGrade2 = value;
                });
              },
            ),
            SizedBox(height: 15),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                myclient().add_content(barcodeController.text, typeController.text, urlController.text, selectedGrade.toString(), selectedGrade2.toString(), selectedSubject.toString());

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
