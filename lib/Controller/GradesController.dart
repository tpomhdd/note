import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GradesController {
  // قائمة الصفوف
  List<dynamic> grades = [];

  // جلب الصفوف من API Laravel
  Future<List<dynamic>> fetchGrades() async {
    final url = Uri.parse(
        'https://schoolnot.tpowep.com/classes/json'); // رابط API
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        grades = json.decode(response.body); // تخزين البيانات
        return grades;
      } else {
        print('Failed to load grades: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<dynamic>> fetchSubjects() async {
    try {
      final response = await http.get(
          Uri.parse('https://schoolnot.tpowep.com/apisubjects'));

      if (response.statusCode == 200) {
        final List<dynamic> subjects = jsonDecode(response.body);
        return subjects; // إعادة قائمة المواد
      } else {
        throw Exception('Failed to load subjects');
      }
    } catch (e) {
      print('Error fetching subjects: $e');

      return []; // إعادة قائمة فارغة في حالة حدوث خطأ
    }
  }
}
  class GradesController2 {
  // قائمة الصفوف
  List<dynamic> grades = [];

  // جلب الصفوف من API Laravel
  Future<List<dynamic>> fetchGrades() async {
  final url = Uri.parse('https://schoolnot.tpowep.com/json'); // رابط API
  try {
  final response = await http.get(url);

  if (response.statusCode == 200) {
  grades = json.decode(response.body); // تخزين البيانات
  return grades;
  } else {
  print('Failed to load grades: ${response.statusCode}');
  return [];
  }
  } catch (e) {
  print('Error: $e');
  return [];
  }
  }
  }
