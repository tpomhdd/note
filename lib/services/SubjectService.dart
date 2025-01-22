import 'dart:convert';
import 'package:http/http.dart' as http;

class SubjectService {
  final String apiUrl = "https://schoolnot.tpowep.com/subjectsjson/";

  Future<String> fetchSubjectName(int subjectId) async {
    final response = await http.get(Uri.parse("$apiUrl$subjectId"));
print('apiUrl$subjectId');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data['name'].toString());
      return data['name']; // جلب اسم المادة
    } else {
      throw Exception('فشل في تحميل اسم المادة');
    }
  }
}
