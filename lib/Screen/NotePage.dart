import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolnot/Screen/BarcodeSlider.dart';
import 'package:schoolnot/Screen/NotebookScreenPage.dart';
import 'package:schoolnot/Screen/PageView.dart';
import 'package:schoolnot/Screen/Pages.dart';
import 'package:schoolnot/Widget/PageContent.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'package:schoolnot/Widget/man_widget/mytext.dart';

import '../Widget/CustomDrawer.dart';
import '../services/PrintService.dart';
import '../services/SubjectService.dart';
class NotePage extends StatefulWidget {
final String id;
final String idnote;
  const NotePage({Key? key, required this.id, required this.idnote}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  String? _username; // اسم المستخدم
  bool _isLoading = false;
  String? _message;
  Map<String, dynamic>? _notebook;
  String? subjectName;
  String? subjectid;
  bool isLoading = true;
  final SubjectService _subjectService = SubjectService();



  Future<void> fetchSubject() async {
    try {
      String name = await _subjectService.fetchSubjectName(int.parse(widget.id));
      setState(() {
        subjectName = name;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        subjectName = "غير متوفر";
        isLoading = false;
      });
    }
  }

  Future<void> fetchNotebook() async {
    setState(() {
      _isLoading = true;
      _message = null;
      _notebook = null;
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _username = widget.idnote;

    if (_username == null || _username!.isEmpty) {
      setState(() {
        _message = 'اسم المستخدم غير متوفر';
        _isLoading = false;
      });
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('https://schoolnot.tpowep.com/notebook-by-id?id=$_username'),
      );
      print('https://schoolnot.tpowep.com/notebook-by-id?id=$_username');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] != null) {
          print(data['data'][0].toString());
          setState(() {
            _notebook = data['data'][0];
            _message = data['message'];
          });
        } else {
          setState(() {
            _message = 'الدفتر غير موجود';
          });
        }
      } else {
        setState(() {
          _message = 'فشل في جلب البيانات';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'حدث خطأ: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  void _resetPage() async {
int      _currentPage = 0;
final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentPage = 0;
    });
    await prefs.setInt('current_page_${widget.id}', _currentPage);
    Navigator.of(context).pop();
  }


  @override
  void initState() {
    super.initState();
    fetchSubject();
    fetchNotebook();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey _globalKey = GlobalKey();


    return Directionality(
      textDirection: TextDirection.ltr,

      child: Scaffold(

        floatingActionButton: FloatingActionButton(
          onPressed: () => PrintService.printScreen(context, _globalKey),
          child: Icon(Icons.print,size: 25,),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat, // تحريك الزر إلى اليسار


        appBar: AppBar(),  backgroundColor: Color(0xFF5A7968), // اللون الأخضر الخلفي
        drawer: CustomDrawer(),
        body: RepaintBoundary(
          key: _globalKey,

          child: Center(
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // الشريط الرمادي العلوي مع النص
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'دفتر مدرسي',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    image: DecorationImage(
                      image: _notebook != null && _notebook!['logoUrl'] != null
                          ? NetworkImage(_notebook!['logoUrl']!)
                          : AssetImage('assets/placeholder.png') as ImageProvider,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

        SizedBox(height: 22,),        InkWell(
                  onTap: (){
                    Get.to(PageViewScreen(id: _notebook!['Subject'].toString(),
     pages:33,
                        idnot:  _notebook!['id'].toString(),));
                  },

          child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'صفحات الدفتر',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
        ),
                SizedBox(height: 100),
                Container(
                  height: 200,
                  child: Row(


                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(

                          padding: EdgeInsets.all(8),
                          child: _notebook != null && _notebook!['Subject'] != null
                              ? Container(
                            color: Colors.transparent,
                            height: 150,
                            width: 100,
                            child: BarcodeSlider20(id: _notebook!['Subject'].toString()),
                          )
                              : Container(
                            height:75 ,
                            width: 75,
                            alignment: Alignment.center,
                            child: Text(
                              'جاري التحميل',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      // الحقول السفلية (اسم، المادة، الصف)
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 250,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildField('الاسم', _notebook != null ? _notebook!['namenot'] ?? '' : ''),
                                SizedBox(height: 10),
                                buildField('الصف', _notebook != null ? _notebook!['grade'] ?? '' : ''),
                                buildField('المادة',subjectName.toString()),
                                SizedBox(height: 10),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // الرقم داخل الدائرة



                // QR Code السفلي

              ],
            ),
          ),
        ),
      ),
    );
  }
}
// Widget لبناء الحقول
Widget buildField(String label , String val) {
  return Row(
    children: [
      Expanded(
        child: Container(
          alignment: Alignment.center,
          height: 40,
    child: MyText(color: Colors.black, text: val, size: 16),      decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey),
          ),
        ),
      ),
      SizedBox(width: 10),
      Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
