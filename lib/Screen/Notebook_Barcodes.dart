import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:schoolnot/Screen/testbarcode.dart';

class BarcodeSlider extends StatefulWidget {
  @override
  _BarcodeSliderState createState() => _BarcodeSliderState();
}

class _BarcodeSliderState extends State<BarcodeSlider> {
  late Future<List<Map<String, String>>> barcodeList;
  Future<List<Map<String, String>>> fetchBarcodes() async {
    final response = await http.get(Uri.parse('https://schoolnot.tpowep.com/jsonContent'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) {
        return {
          'content_url': item['content_url'].toString(),
          'barcode_id': item['barcode_id'].toString(), // إضافة الحقل address
        };
      }).toList();
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
    return FutureBuilder<List<Map<String, String>>>(
      future: barcodeList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('حدث خطأ: ${snapshot.error}'));
        }
        final barcodes = snapshot.data ?? [];
        return PageView.builder(
          itemCount: barcodes.length,
          itemBuilder: (context, index) {
            return Center(child: BarcodePage(url: barcodes[index]['content_url'].toString(), address:  barcodes[index]['barcode_id'].toString(),)); // عرض الباركود

          },
        );
      },
    );

  }
}
