import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<Uint8List> generateAriel(PdfPageFormat format) async {
  final doc = pw.Document(pageMode: PdfPageMode.outlines);

  final font1 = await PdfGoogleFonts.openSansRegular();
  final font2 = await PdfGoogleFonts.openSansBold();
  final shape = await rootBundle.loadString('assets/document.svg');
  final swirls = await rootBundle.loadString('assets/swirls2.svg');

  doc.addPage(
    pw.Page(
      pageTheme: pw.PageTheme(
        pageFormat: format.copyWith(
          marginBottom: 0,
          marginLeft: 0,
          marginRight: 0,
          marginTop: 0,
        ),
        orientation: pw.PageOrientation.portrait,
        buildBackground: (context) =>
            pw.SvgImage(svg: shape, fit: pw.BoxFit.fill),
        theme: pw.ThemeData.withFont(
          base: font1,
          bold: font2,
        ),
      ),
      build: (context) {
        return pw.Padding(
          padding: const pw.EdgeInsets.only(
            left: 60,
            right: 60,
            bottom: 30,
          ),
          child: pw.Column(
            children: [
              pw.Spacer(),
              pw.RichText(
                  text: pw.TextSpan(children: [
                pw.TextSpan(
                  text: DateTime.now().year.toString() + '\n',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.grey600,
                    fontSize: 40,
                  ),
                ),
                pw.TextSpan(
                  text: 'Portable Document Format',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ])),
              pw.Spacer(),
              pw.Container(
                alignment: pw.Alignment.topRight,
                height: 150,
                child: pw.PdfLogo(),
              ),
              pw.Spacer(flex: 2),
              pw.Align(
                alignment: pw.Alignment.topLeft,
                child: pw.UrlLink(
                  destination: 'https://wikipedia.org/wiki/PDF',
                  child: pw.Text(
                    'https://wikipedia.org/wiki/PDF',
                    style: const pw.TextStyle(
                      color: PdfColors.pink100,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );

  return await doc.save();
}
