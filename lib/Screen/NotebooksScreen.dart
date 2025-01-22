import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolnot/Screen/NotePage.dart';
import '../Model/Notebook.dart';
import '../Widget/CustomDrawer.dart';
import '../services/NotebookService.dart';

class NotebooksScreen extends StatefulWidget {
  final String phoneNumber;

  NotebooksScreen({required this.phoneNumber});

  @override
  _NotebooksScreenState createState() => _NotebooksScreenState();
}

class _NotebooksScreenState extends State<NotebooksScreen> {
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
      final notebooks = await _notebookService.fetchNotebooks();
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
        appBar: AppBar(
          title: Text('دفاتري'),
          backgroundColor: Colors.blueAccent,
        ),
        drawer: CustomDrawer(),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : _notebooks.isEmpty
              ? Center(
            child: Text(
              'لا توجد دفاتر متاحة.',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          )
              : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              itemCount: _notebooks.length,
              itemBuilder: (context, index) {
                final notebook = _notebooks[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(NotePage(
                        id: notebook.subject.toString()??'',
                        idnote: notebook.id.toString()??'',
                      ));
                    },
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white.withOpacity(0.9),
                        ),
                        child: Row(
                          children: [
                            // صورة الدفتر


                            Container(
                              width: 80,
                              height: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 3),
                                image: DecorationImage(
                                  image: notebook != null && notebook.logoUrl != null
                                      ? NetworkImage(notebook.logoUrl)
                                      : AssetImage('assets/placeholder.png') as ImageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            // معلومات الدفتر
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      notebook.name.toString(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'الصف: ${notebook.grade}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
