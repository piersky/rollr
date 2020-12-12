import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';

class PdfWorkout {
  //https://pub.dev/packages/pdf#-example-tab-
  var pdf = pw.Document();

  void createPdf() async {
    final image = PdfImage.file(
      pdf.document,
      bytes: io.File('test.webp').readAsBytesSync(),
    );

    //final Uint8List fontData = io.File('open-sans.ttf').readAsBytesSync();
    //final ttf = pw.Font.ttf(fontData.buffer.asByteData());

    final output = await getTemporaryDirectory();
    final file = io.File("${output.path}/example.pdf");
    //final file = io.File("example.pdf");
    await file.writeAsBytes(pdf.save());

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(
              'Hello World',
              style: pw.TextStyle(fontSize: 40),
            ),
          ); // Center
        },
      ),
    ); // Page
/*
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Hello World"),
          ); // Center
        })); // Page
    */
  }
}
