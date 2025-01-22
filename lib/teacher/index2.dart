import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolnot/teacher/getNotebookall.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:schoolnot/teacher/classroom.dart';

class teacher extends StatelessWidget {
  const teacher({Key? key}) : super(key: key);

  Future<String> _getUserName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("username") ?? "ضيف";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الصفحة الرئيسية',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4,
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<String>(
            future: _getUserName(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("حدث خطأ أثناء استرجاع اسم المستخدم"));
              } else {
                String userName = snapshot.data ?? "ضيف";
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: Colors.blueAccent,
                          size: 50,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'مرحبًا، $userName',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      _buildMenuButton(
                        label: 'عرض الصفوف',
                        icon: Icons.view_list,
                        onPressed: () => Get.to(ClassListScreen()),
                      ),
                      _buildMenuButton(
                        label: 'عرض الدفاتر',
                        icon: Icons.note_add_outlined,
                        onPressed: () {
                          Get.to(getNotebookall(phoneNumber: ''
                              ''));
                          // المنطق الخاص بعرض الدفاتر
                        },
                      ),
                      _buildMenuButton(
                        label: 'الإعدادات',
                        icon: Icons.settings,
                        onPressed: () {
                          // المنطق الخاص بالإعدادات
                        },
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 24),
        label: Text(
          label,
          style: TextStyle(fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15),
          backgroundColor: Colors.white,
          foregroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Colors.blueAccent, width: 2),
          ),
          elevation: 5,
        ),
      ),
    );
  }
}
