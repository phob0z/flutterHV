import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

const PdfColor green = PdfColor.fromInt(0xff9ce5d0);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);

Future<Uint8List> generateRaul(PdfPageFormat format) async {
  // final doc = pw.Document(pageMode: PdfPageMode.outlines);

  final font1 = await PdfGoogleFonts.openSansRegular();
  final font2 = await PdfGoogleFonts.openSansBold();

  final doc =
      pw.Document(title: 'Hoja de Vida de Raúl', author: 'Raúl Tenorio');

  final profileImage = pw.MemoryImage(
    (await rootBundle.load('assets/raul.jpg')).buffer.asUint8List(),
  );

  final pageTheme = await _myPageTheme(format);

  doc.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      build: (pw.Context context) => [
        pw.Partitions(
          children: [
            pw.Partition(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Container(
                    padding: const pw.EdgeInsets.only(left: 30, bottom: 20),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: <pw.Widget>[
                        pw.Text('Raúl Tenorio',
                            textScaleFactor: 2,
                            style: pw.Theme.of(context)
                                .defaultTextStyle
                                .copyWith(fontWeight: pw.FontWeight.bold)),
                        pw.Padding(padding: const pw.EdgeInsets.only(top: 10)),
                        pw.Text('Desarrollador de Software',
                            textScaleFactor: 1.2,
                            style: pw.Theme.of(context)
                                .defaultTextStyle
                                .copyWith(
                                    fontWeight: pw.FontWeight.bold,
                                    color: green)),
                        pw.Padding(padding: const pw.EdgeInsets.only(top: 20)),
                        pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: <pw.Widget>[
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: <pw.Widget>[
                                pw.Text('20 años'),
                                pw.Text('Quitumbe S33 y Quipu'),
                                pw.Text('Quito, Ecuador'),
                              ],
                            ),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: <pw.Widget>[
                                pw.Text('+593 967-363-998'),
                                pw.Text('tenorio0967@hotmail.com'),
                                pw.Text('https://github.com/raul-tenorio'),
                              ],
                            ),
                            pw.Padding(padding: pw.EdgeInsets.zero)
                          ],
                        ),
                      ],
                    ),
                  ),
                  pw.Text('EXPERIENCIA LABORAL'),
                  pw.Text('-   Soft Warehouse S.A.'),
                  pw.Text('    Cargo: Programador Junior'),
                  pw.Text('    Tiempo: 11 meses'),
                  pw.SizedBox(height: 20),
                  pw.Text('EDUCACIÓN'),
                  pw.Text('-   Primaria:'),
                  pw.Text('    Escuela Eduardo Carrión Eguiguren'),
                  pw.SizedBox(height: 5),
                  pw.Text('-   Secundaria:'),
                  pw.Text(
                      '    Institución Educativa Fiscal "Miguel de Santiago"'),
                  pw.SizedBox(height: 5),
                  pw.Text('-   Terciaria:'),
                  pw.Text('    Escuela Politécnica Nacional'),
                  pw.SizedBox(height: 20),
                  pw.Text('CONOCIMIENTOS'),
                  pw.Text('-   Java'),
                  pw.Text('-   JavaScript'),
                  pw.Text('-   HTML'),
                  pw.Text('-   CSS'),
                  pw.Text('-   C++'),
                  pw.Text('-   C'),
                  pw.Text('-   C#'),
                  pw.Text('-   Python'),
                  pw.Text('-   PHP'),
                  pw.Text('-   NodeJS'),
                  pw.Text('-   Laravel'),
                  pw.Text('-   Ionic'),
                  pw.Text('-   Flutter'),
                ],
              ),
            ),
            pw.Partition(
              width: 120,
              child: pw.Column(
                children: [
                  pw.Container(
                    height: pageTheme.pageFormat.availableHeight,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: <pw.Widget>[
                        pw.ClipOval(
                          child: pw.Container(
                            width: 100,
                            height: 100,
                            color: lightGreen,
                            child: pw.Image(profileImage),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    ),
  );
  return doc.save();
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  // final bgShape = await rootBundle.loadString('assets/resume.svg');

  format = format.applyMargin(
      left: 2.0 * PdfPageFormat.cm,
      top: 4.0 * PdfPageFormat.cm,
      right: 2.0 * PdfPageFormat.cm,
      bottom: 2.0 * PdfPageFormat.cm);
  return pw.PageTheme(
    pageFormat: format,
    theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.openSansRegular(),
      bold: await PdfGoogleFonts.openSansBold(),
      icons: await PdfGoogleFonts.materialIcons(),
    ),
  );
}
