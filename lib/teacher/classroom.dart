import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:schoolnot/Screen/AddClass.dart';
import 'package:schoolnot/Widget/man_widget/mytext.dart';
import 'package:schoolnot/teacher/add_sections.dart';
import 'package:schoolnot/teacher/notebookgrade.dart';



class ClassListScreen extends StatefulWidget {
  @override
  _ClassListScreenState createState() => _ClassListScreenState();
}

class _ClassListScreenState extends State<ClassListScreen> {
  List<ClassModel> classList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchClasses();
  }

  Future<void> fetchClasses() async {
    final url = Uri.parse('https://schoolnot.tpowep.com/classjson');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          classList = jsonData.map((e) => ClassModel.fromJson(e)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('فشل في تحميل البيانات');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('خطأ: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black87,

bottomNavigationBar:           ElevatedButton.icon(
  onPressed: () {
      Get.to(AddClass());

      // المنطق الخاص بعرض الصفوف
  },
  icon: Icon(Icons.view_list, size: 24),
  label: Text(
      'اضافة صف',
      style: TextStyle(fontSize: 18),
  ),
  style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: 15),
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,

  ),
),
             body: Stack(
          children: [
            // الخلفية
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.green],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),

            // الطبقة العلوية مع تعتيم الخلفية
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),

            // المحتوى
            Column(
              children: [
                AppBar(
                  title: Text("قائمة الفصول الدراسية"),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: true,
                ),
                Expanded(
                  child: isLoading
                      ? Center(child: CircularProgressIndicator())
                      : classList.isEmpty
                      ? Center(child: Text("لا توجد بيانات متاحة", style: TextStyle(color: Colors.white, fontSize: 18)))
                      : ListView.builder(
                    itemCount: classList.length,
                    itemBuilder: (context, index) {
                      final classItem = classList[index];
                      return Card(
                        elevation: 6,
                        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8), // شفافية لتمييز النصوص
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(15),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blueAccent,
                                  child: Text(
                                    classItem.classId.toString(),
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                title: Text(
                                  "الصف: ${classItem.className}",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5),
                                    Text(
                                      "المعلم: ${classItem.teacherName.isNotEmpty ? classItem.teacherName : 'غير متوفر'}",
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                    Text(
                                      "الشعبة: ${classItem.sectionName}",
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                  width: double.infinity,
                      color: Colors.blue,
                      child: InkWell(
                        onTap: (){
                          Get.to(add_sections(idclass: classItem.classId.toString(),));
                        },
                        child: MyText(color: Colors.white, text: 'اضافة شعبة', size: 16),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                  width: double.infinity,
                      color: Colors.blue,
                      child: InkWell(
                        onTap: (){
                          Get.to(getNotebookgrde(name: classItem.className, id: classItem.classId.toString(),));
                        },
                        child: MyText(color: Colors.white, text: 'دفاتر الصف', size: 16),
                      ),
                    ),
                  )

                                  ],
                                ),
                                trailing: Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ClassModel {
  final int classId;
  final String className;
  final String teacherName;
  final int sectionId;
  final String sectionName;

  ClassModel({
    required this.classId,
    required this.className,
    required this.teacherName,
    required this.sectionId,
    required this.sectionName,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      classId: json['class_id'],
      className: json['class_name'],
      teacherName: json['teacher_name'] ?? '',
      sectionId: json['section_id'],
      sectionName: json['section_name'],
    );
  }
}
