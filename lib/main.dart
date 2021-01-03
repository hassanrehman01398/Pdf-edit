import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart' as pdf;
import 'package:pdf/widgets.dart' as pdfWidget;
import 'package:pdf/widgets/font.dart';
import 'package:pdf_edit/pdf_editor_service.dart';
import 'package:printing/printing.dart';

import 'package:pdf/widgets.dart' as pdfLib;

import 'pdf_editor_service.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Edit Pdf Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _edit() async {
    PdfMutableDocument doc = await PdfMutableDocument.asset("assets/test.pdf");
   print("afnan");
    print(doc);
    _editDocument(doc);
    await doc.save(filename: "modified.pdf");

   // Printing.sharePdf(bytes:doc.build().save(), filename: 'test_pdf.pdf');
    print("PDF Edition Done");
  }

  void _editDocument(PdfMutableDocument document) async {
    var page = document.getPage(0);
//    print("hassan check");
//    final font = await rootBundle.load("assets/OpenSans-Bold.ttf");
//    final ttf = Font.ttf(font);


    final font = await rootBundle.load("assets/OpenSans-Bold.ttf");
    final ttf = pdfLib.Font.ttf(font);
    final fontBold = await rootBundle.load("assets/OpenSans-BoldItalic.ttf");
    final ttfBold = pdfLib.Font.ttf(fontBold);
    final fontItalic = await rootBundle.load("assets/OpenSans-Italic.ttf");
    final ttfItalic = pdfLib.Font.ttf(fontItalic);
    final fontBoldItalic =
    await rootBundle.load("assets/OpenSans-Regular.ttf");
    final ttfBoldItalic = pdfLib.Font.ttf(fontBoldItalic);
    final pdfLib.ThemeData theme = pdfLib.Theme.withFont(
      base: ttf,
      bold: ttfBold,
      italic: ttfItalic,
      boldItalic: ttfBoldItalic,
    );
    page.add(item: pdfWidget.Positioned(
    left: 20.0,
    top: 100.0,
    child: pdfWidget.Text("Hassan ur rehman",
    style: pdfWidget.TextStyle(font: ttf,fontSize: 60),
    )));
    var centeredText = pdfWidget.Center(
    child: pdfWidget.Text(
    "CENTERED TEXT",
    style: pdfWidget.TextStyle(font: ttf,
    fontSize: 100,
    background: pdfWidget.BoxDecoration())));

    page.add(item: centeredText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _edit,
        tooltip: 'Load',
        icon: Icon(Icons.file_download),
        label: Text("Modify"),
      ),
    );
  }
}
