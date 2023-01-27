import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

PdfColor blue = PdfColor.fromHex('#1F4A8A');

Future<Uint8List> generateLeonel(PdfPageFormat format) async {
  final doc =
      pw.Document(title: 'Hoja de Vida de Leonel', author: 'Leonel Molina');

  final profileImage = pw.MemoryImage(
    (await rootBundle.load('assets/leonel.jpg')).buffer.asUint8List(),
  );

  final pageTheme = await _myPageTheme(format);

  doc.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      build: (pw.Context context) => [
        pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: <pw.Widget>[
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Text('Leonel A. Molina T.',
                      textScaleFactor: 2.2,
                      style: pw.Theme.of(context)
                          .defaultTextStyle
                          .copyWith(fontWeight: pw.FontWeight.bold)),
                  pw.Padding(padding: const pw.EdgeInsets.only(top: 30)),
                  pw.Text('Desarrollador',
                      textScaleFactor: 1.5,
                      style: pw.Theme.of(context).defaultTextStyle.copyWith(
                          fontWeight: pw.FontWeight.bold, color: blue)),
                  pw.Padding(padding: const pw.EdgeInsets.only(top: 20)),
                  pw.Text('- INFORMACIÓN:',
                      style: pw.Theme.of(context).defaultTextStyle.copyWith(
                          fontWeight: pw.FontWeight.bold, color: blue)),
                  pw.Text('Correo: leonel.alfonso@gmail.com'),
                  pw.Text('Teléfono: +593 96 3680605'),
                  pw.Text('Quito, Ecuador'),
                  pw.Padding(padding: const pw.EdgeInsets.only(top: 20)),
                  pw.Text('- HOBBIES:',
                      style: pw.Theme.of(context).defaultTextStyle.copyWith(
                          fontWeight: pw.FontWeight.bold, color: blue)),
                  pw.Text('Computación'),
                  pw.Text('Puzzles'),
                  pw.Text('Barismo'),
                ],
              ),
              pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: <pw.Widget>[
                        pw.ClipOval(
                          child: pw.Container(
                            width: 100,
                            height: 100,
                            child: pw.Image(profileImage),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(children: [
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Padding(
                                padding: const pw.EdgeInsets.only(top: 20)),
                            pw.Text('- IDIOMAS:',
                                style: pw.Theme.of(context)
                                    .defaultTextStyle
                                    .copyWith(
                                        fontWeight: pw.FontWeight.bold,
                                        color: blue)),
                            pw.Text('Ingles'),
                            pw.Text('Español'),
                            pw.Padding(
                                padding: const pw.EdgeInsets.only(top: 20)),
                          ])
                    ])
                  ]),
            ]),
        pw.Padding(padding: const pw.EdgeInsets.only(top: 20)),
        pw.Paragraph(
            text:
                'Soy estudiante del último semestre de Desarrollo de Software en la Escuela Politécnica Nacional del Ecuador y ex estudiante de Ingeniería de Sistemas con mención computación de la Universidad de los Andes de Venezuela, apasionado por la computación, la programación, la lógica y el diseño, me considero una persona muy proactiva, siempre con la mejor actitud, paciente, responsable, con sentido del humor, y buena capacidad de trabajo en equipo, continuamente buscando ampliar mis conocimientos y mejorar en cada aspecto. He trabajado'
                'en diferentes proyectos académicos en diversos lenguajes de programación como C, C++,'
                'Python, Java, Javascript, con librerías como ReactJS, y en el ámbito no académico, he tenido'
                'la oportunidad aprender y desarrollarme como barista, en el área de ventas, administración'
                'de personal y atención al público'),
      ],
    ),
  );
  return doc.save();
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
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
    ),
  );
}
