import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GradesDropdownPage extends StatefulWidget {
  @override
  _GradesDropdownPageState createState() => _GradesDropdownPageState();
}

class _GradesDropdownPageState extends State<GradesDropdownPage> {
  List<dynamic> grades = []; // قائمة الصفوف
  String? selectedGrade; // الصف المختار

  // جلب البيانات من API Laravel
  Future<void> fetchGrades() async {
    final url = Uri.parse('https://schoolnot.tpowep.com/classes/json'); // رابط API
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          grades = json.decode(response.body); // تخزين البيانات
        });
      } else {
        print('Failed to load grades: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchGrades(); // جلب البيانات عند تشغيل الصفحة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اختيار الصف'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: grades.isEmpty
            ? CircularProgressIndicator() // عرض مؤشر أثناء تحميل البيانات
            : DropdownButton<String>(
          value: selectedGrade,
          hint: Text('اختر صفًا'),
          items: grades.map((grade) {
            return DropdownMenuItem<String>(
              value: grade['name'], // قيمة العنصر
              child: Text(grade['name']), // نص العنصر
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedGrade = value; // حفظ الصف المختار
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('تم اختيار: $value')),
            );
          },
        ),
      ),
    );
  }
}
