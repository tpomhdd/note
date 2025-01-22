import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/Notebook.dart';

class NotebookService {

  Future<List<Notebook>> fetchNotebooks() async {
    SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String username = sharedPreferences.get("username").toString();

    final url = Uri.parse('https://schoolnot.tpowep.com/notebookss?phone=${username}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final notebooksData = responseData['data'] as List;

      return notebooksData.map((notebook) => Notebook.fromJson(notebook)).toList();
    } else {
      throw Exception('Failed to load notebooks');
    }
  }
    Future<List<Notebook>> fetchNotebooksgrade(String grade) async {
    SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String username = sharedPreferences.get("username").toString();

    final url = Uri.parse('https://schoolnot.tpowep.com/notebook-by-grade?grade=${grade}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final notebooksData = responseData['data'] as List;

      return notebooksData.map((notebook) => Notebook.fromJson(notebook)).toList();
    } else {
      throw Exception('Failed to load notebooks');
    }
  }
  Future<List<Notebook>> fetchNotebooksall() async {
    try {
      final response = await http.get(Uri.parse('https://schoolnot.tpowep.com/getNotebookall'));

      print("🔹 استجابة السيرفر: ${response.body}"); // ✅ يطبع الرد القادم من API

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);

        if (decodedData is Map<String, dynamic> && decodedData.containsKey('notebook')) {
          final List<dynamic> notebookList = decodedData['notebook'];

          print("✅ البيانات المستخرجة: $notebookList"); // ✅ يطبع البيانات بعد الاستخراج

          return notebookList.map((json) => Notebook.fromJson(json)).toList();
        } else {
          print("⚠️ خطأ: لم يتم العثور على مفتاح 'data' في الرد!");
          return [];
        }
      } else {
        print("❌ خطأ في الاستجابة: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("❌ استثناء أثناء جلب البيانات: $e");
      return [];
    }
  }}
