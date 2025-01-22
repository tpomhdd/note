import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
class BarcodePage extends StatelessWidget {
  final String url;
  final String address;

  BarcodePage({required this.url, required this.address});

  Future<void> _launchURL(String url) async {

    final Uri _url = Uri.parse(url);

    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $_url';
    }
  }
  @override
  Widget build(BuildContext context) {
    // رابط مخصص يعتمد على معرّف الطالب


    return                      Padding(
      padding: EdgeInsets.all(7.0),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                address,

                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
SizedBox(height: 22,),
              InkWell(
                onTap: (){
                  _launchURL(url);
                },
                child: BarcodeWidget(
                  backgroundColor: Colors.transparent,
                  barcode: Barcode.qrCode(),
                  data: url, // البيانات لتوليد الباركود
                  width: 50,
                  height:  50,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
