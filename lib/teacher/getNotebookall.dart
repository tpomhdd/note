//getNotebookall
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolnot/Screen/NotePage.dart';
import 'package:schoolnot/Screen/NotebookCustomizationScreen.dart';
import 'package:schoolnot/Screen/Notebook_Barcodes.dart';
import 'package:schoolnot/Screen/NotebooksScreen.dart';
import 'package:schoolnot/Screen/testbarcode.dart';
import 'package:schoolnot/teacher/update_notebook.dart';

import '../Model/Notebook.dart';
import '../Widget/man_widget/mytext.dart';
import '../services/NotebookService.dart';


class getNotebookall extends StatefulWidget {
  final String phoneNumber;

  getNotebookall({required this.phoneNumber});

  @override
  _getNotebookallState createState() => _getNotebookallState();
}

class _getNotebookallState extends State<getNotebookall> {
  late NotebookService _notebookService;
  List<Notebook> _notebooks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _notebookService = NotebookService();
    _fetchNotebooks();
  }

  Future<void> _fetchNotebooks() async {
    try {
      final notebooks = await _notebookService.fetchNotebooksall();
      setState(() {
        _notebooks = notebooks;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء تحميل الدفاتر: $e')),
      );
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(

        bottomNavigationBar:           ElevatedButton.icon(
          onPressed: () {
            Get.to(NotebookCustomizationScreen());

            // المنطق الخاص بعرض الصفوف
          },
          icon: Icon(Icons.view_list, size: 24),
          label: Text(
            'اضافة دفتر',
            style: TextStyle(fontSize: 18),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15),
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,

          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.green],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : _notebooks.isEmpty
              ? Center(child: Text('لا توجد دفاتر متاحة.', style: TextStyle(fontSize: 18, color: Colors.white)))
              : Container(
            height: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 100,)   ,                 Center(
                  child: Text(
                    'كل الدفاتر',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                SingleChildScrollView(
                  child: Container(
                    height: 550,
                    child: ListView.builder(
                      itemCount: _notebooks.length,
                      itemBuilder: (context, index) {
                        final notebook = _notebooks[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: Offset(0, 4), // Shadow direction
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(16),
                              title: Text(
                                notebook.name.toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              subtitle: Text(
                                'الصف: ${notebook.grade}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
leading:
InkWell(
  onTap: (){
    Get.to(update_notebook(id: notebook.id.toString()));


  },
  child:   BarcodeWidget(
    backgroundColor: Colors.transparent,
    barcode: Barcode.qrCode(),
    //data: url, // البيانات لتوليد الباركود
    width: 50,
    height:  50,
    color: Colors.black, data: '',
  ),
),
                              onTap: () {
                                notebook.subject;
                           //Get.to(NotePage(id: notebook.subject.toString(),idnote: notebook.id.toString(),));
                                Get.to(                        NotePage(
                                  id: notebook.subject.toString()??'',
                                  idnote: notebook.id.toString()??'',
                                ));



                                // توجيه المستخدم لصفحة التفاصيل (يمكنك إضافة صفحة تفاصيل هنا)
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
