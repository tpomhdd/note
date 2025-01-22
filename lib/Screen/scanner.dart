import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class QRLinkScanner extends StatefulWidget {
  @override
  _QRLinkScannerState createState() => _QRLinkScannerState();
}

class _QRLinkScannerState extends State<QRLinkScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? qrResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR Code Scanner')),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                qrResult != null ? 'Scanned: $qrResult' : 'Scan a QR Code',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (scanData.code != null && scanData.code!.startsWith('http')) {
        // التأكد من أن البيانات الممسوحة هي رابط
        controller.pauseCamera(); // إيقاف الكاميرا مؤقتًا
        await _launchURL(scanData.code!); // الذهاب إلى الرابط
        controller.resumeCamera(); // استئناف الكاميرا
      } else {
        setState(() {
          qrResult = 'Invalid QR Code: ${scanData.code}';
        });
      }
    });
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      setState(() {
        qrResult = 'Could not launch $url';
      });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
