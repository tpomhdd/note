import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:schoolnot/Screen/testbarcode.dart';

class BarcodeSliderPages extends StatefulWidget {
  final String id;
  final int pages;
  BarcodeSliderPages({required this.id, required this.pages});
  @override
  _BarcodeSliderPagesState createState() => _BarcodeSliderPagesState();
}

class _BarcodeSliderPagesState extends State<BarcodeSliderPages> {
  late Future<List<Map<String, String>>> barcodeList;
  Future<List<Map<String, String>>> fetchBarcodes() async {
    final response = await http.get(Uri.parse('https://schoolnot.tpowep.com/contentsub?subject_id=${widget.id}'));

    if (response.statusCode == 200) {
      final List<dynamic> rawData = json.decode(response.body);

      // فك التعشيش (Extract inner list)
      if (rawData.isNotEmpty && rawData[0] is List) {
        final List<dynamic> nestedData = rawData[0]; // استخدام القائمة الداخلية
        return nestedData.map((item) {
          return {
            'content_url': item['content_url'].toString(),
            'barcode_id': item['barcode_id'].toString(),
          };
        }).toList();
      } else {
        throw Exception('تنسيق البيانات غير متوقع');
      }
    } else {
      throw Exception('فشل تحميل البيانات');
    }
  }

  @override
  void initState() {
    super.initState();
    barcodeList = fetchBarcodes();
  }

  @override
  Widget build(BuildContext context) {
    return


      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.transparent,
              height:580,
              width: 800,
              child: FutureBuilder<List<Map<String, String>>>(
                future: barcodeList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    print('حدث خطأ: ${snapshot.error}');
                    return Center(child: Text('حدث خطأ: ${snapshot.error}'));
                  }

                  final barcodes = snapshot.data ?? [];
                  return PageView.builder(
                    itemCount: barcodes.length,
                    itemBuilder: (context, index) {
                      return Container(
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width, // عرض الشاشة
                          height: MediaQuery.of(context).size.height, // ارتفاع الشاشة

                          child: BarcodePage(

                            url: barcodes[index]['content_url'].toString(), address:  barcodes[index]['barcode_id'].toString(),)); // عرض الباركود

                    },
                  );
                },
              ),
            ),
          ],
        ),
      );




  }
}
