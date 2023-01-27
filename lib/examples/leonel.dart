import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

const PdfColor green = PdfColor.fromInt(0xff9ce5d0);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);

Future<Uint8List> generateLeonel(PdfPageFormat format) async {
  // final doc = pw.Document(pageMode: PdfPageMode.outlines);

  final font1 = await PdfGoogleFonts.openSansRegular();
  final font2 = await PdfGoogleFonts.openSansBold();

  final doc =
      pw.Document(title: 'Hoja de Vida de Leonel', author: 'David PHAM-VAN');

  final profileImage = pw.MemoryImage(
    (await rootBundle.load('assets/leonel.jpg')).buffer.asUint8List(),
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
                        pw.Text('Parnella Charlesbois',
                            textScaleFactor: 2,
                            style: pw.Theme.of(context)
                                .defaultTextStyle
                                .copyWith(fontWeight: pw.FontWeight.bold)),
                        pw.Padding(padding: const pw.EdgeInsets.only(top: 10)),
                        pw.Text('Electrotyper',
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
                                pw.Text('568 Port Washington Road'),
                                pw.Text('Nordegg, AB T0M 2H0'),
                                pw.Text('Canada, ON'),
                              ],
                            ),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: <pw.Widget>[
                                pw.Text('+1 403-721-6898'),
                                pw.Text('p.charlesbois@yahoo.com'),
                                pw.Text('wholeprices.ca'),
                              ],
                            ),
                            pw.Padding(padding: pw.EdgeInsets.zero)
                          ],
                        ),
                      ],
                    ),
                  ),
                  pw.Text('Work Experience'),
                  pw.Text('Tour bus driver'),
                  pw.Text('Logging equipment operator'),
                  pw.Text('Foot doctor'),
                  pw.Text('Unicorn trainer'),
                  pw.Text('Chief chatter'),
                  pw.SizedBox(height: 20),
                  pw.Text('Education'),
                  pw.Text('Bachelor Of Commerce'),
                  pw.Text('Bachelor Interior Design'),
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
                        pw.Column(children: <pw.Widget>[
                          pw.Text('Word'),
                          pw.Text('Excel'),
                        ]),
                        pw.BarcodeWidget(
                          data: 'Parnella Charlesbois',
                          width: 60,
                          height: 60,
                          barcode: pw.Barcode.qrCode(),
                          drawText: false,
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
    // buildBackground: (pw.Context context) {
    //   return pw.FullPage(
    //     ignoreMargins: true,
    //     child: pw.Stack(
    //       children: [
    //         pw.Positioned(
    //           child: pw.SvgImage(svg: bgShape),
    //           left: 0,
    //           top: 0,
    //         ),
    //         pw.Positioned(
    //           child: pw.Transform.rotate(
    //               angle: 3.14, child: pw.SvgImage(svg: bgShape)),
    //           right: 0,
    //           bottom: 0,
    //         ),
    //       ],
    //     ),
    //   );
    // },
  );
}

  // doc.addPage(pw.MultiPage(
  //     theme: pw.ThemeData.withFont(
  //       base: font1,
  //       bold: font2,
  //     ),
  //     pageFormat: format.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
  //     orientation: pw.PageOrientation.portrait,
  //     crossAxisAlignment: pw.CrossAxisAlignment.start,
  //     header: (pw.Context context) {
  //       if (context.pageNumber == 1) {
  //         return pw.SizedBox();
  //       }
  //       return pw.Container(
  //           alignment: pw.Alignment.centerRight,
  //           margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
  //           padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
  //           decoration: const pw.BoxDecoration(
  //               border: pw.Border(
  //                   bottom: pw.BorderSide(width: 0.5, color: PdfColors.grey))),
  //           child: pw.Text('Portable Document Format',
  //               style: pw.Theme.of(context)
  //                   .defaultTextStyle
  //                   .copyWith(color: PdfColors.grey)));
  //     },
  //     footer: (pw.Context context) {
  //       return pw.Container(
  //           alignment: pw.Alignment.centerRight,
  //           margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
  //           child: pw.Text(
  //               'Page ${context.pageNumber} of ${context.pagesCount}',
  //               style: pw.Theme.of(context)
  //                   .defaultTextStyle
  //                   .copyWith(color: PdfColors.grey)));
  //     },
  //     build: (pw.Context context) => <pw.Widget>[
  //           pw.Header(
  //               level: 0,
  //               title: 'Portable Document Format',
  //               child: pw.Row(
  //                   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                   children: <pw.Widget>[
  //                     pw.Text('Portable Document Format', textScaleFactor: 2),
  //                     pw.PdfLogo()
  //                   ])),
  //           pw.Paragraph(
  //               text:
  //                   'The Portable Document Format (PDF) is a file format developed by Adobe in the 1990s to present documents, including text formatting and images, in a manner independent of application software, hardware, and operating systems. Based on the PostScript language, each PDF file encapsulates a complete description of a fixed-layout flat document, including the text, fonts, vector graphics, raster images and other information needed to display it. PDF was standardized as an open format, ISO 32000, in 2008, and no longer requires any royalties for its implementation.'),
  //           pw.Paragraph(
  //               text:
  //                   'Today, PDF files may contain a variety of content besides flat text and graphics including logical structuring elements, interactive elements such as annotations and form-fields, layers, rich media (including video content) and three dimensional objects using U3D or PRC, and various other data formats. The PDF specification also provides for encryption and digital signatures, file attachments and metadata to enable workflows requiring these features.'),
  //           pw.Header(level: 1, text: 'History and standardization'),
  //           pw.Paragraph(
  //               text:
  //                   "Adobe Systems made the PDF specification available free of charge in 1993. In the early years PDF was popular mainly in desktop publishing workflows, and competed with a variety of formats such as DjVu, Envoy, Common Ground Digital Paper, Farallon Replica and even Adobe's own PostScript format."),
  //           pw.Paragraph(
  //               text:
  //                   'PDF was a proprietary format controlled by Adobe until it was released as an open standard on July 1, 2008, and published by the International Organization for Standardization as ISO 32000-1:2008, at which time control of the specification passed to an ISO Committee of volunteer industry experts. In 2008, Adobe published a Public Patent License to ISO 32000-1 granting royalty-free rights for all patents owned by Adobe that are necessary to make, use, sell, and distribute PDF compliant implementations.'),
  //           pw.Paragraph(
  //               text:
  //                   "PDF 1.7, the sixth edition of the PDF specification that became ISO 32000-1, includes some proprietary technologies defined only by Adobe, such as Adobe XML Forms Architecture (XFA) and JavaScript extension for Acrobat, which are referenced by ISO 32000-1 as normative and indispensable for the full implementation of the ISO 32000-1 specification. These proprietary technologies are not standardized and their specification is published only on Adobe's website. Many of them are also not supported by popular third-party implementations of PDF."),
  //           pw.Paragraph(
  //               text:
  //                   'On July 28, 2017, ISO 32000-2:2017 (PDF 2.0) was published. ISO 32000-2 does not include any proprietary technologies as normative references.'),
  //           pw.Header(level: 1, text: 'Technical foundations'),
  //           pw.Paragraph(text: 'The PDF combines three technologies:'),
  //           pw.Bullet(
  //               text:
  //                   'A subset of the PostScript page description programming language, for generating the layout and graphics.'),
  //           pw.Bullet(
  //               text:
  //                   'A font-embedding/replacement system to allow fonts to travel with the documents.'),
  //           pw.Bullet(
  //               text:
  //                   'A structured storage system to bundle these elements and any associated content into a single file, with data compression where appropriate.'),
  //           pw.Header(level: 2, text: 'PostScript'),
  //           pw.Paragraph(
  //               text:
  //                   'PostScript is a page description language run in an interpreter to generate an image, a process requiring many resources. It can handle graphics and standard features of programming languages such as if and loop commands. PDF is largely based on PostScript but simplified to remove flow control features like these, while graphics commands such as lineto remain.'),
  //           pw.Paragraph(
  //               text:
  //                   'Often, the PostScript-like PDF code is generated from a source PostScript file. The graphics commands that are output by the PostScript code are collected and tokenized. Any files, graphics, or fonts to which the document refers also are collected. Then, everything is compressed to a single file. Therefore, the entire PostScript world (fonts, layout, measurements) remains intact.'),
  //           pw.Column(
  //               crossAxisAlignment: pw.CrossAxisAlignment.start,
  //               children: <pw.Widget>[
  //                 pw.Paragraph(
  //                     text:
  //                         'As a document format, PDF has several advantages over PostScript:'),
  //                 pw.Bullet(
  //                     text:
  //                         'PDF contains tokenized and interpreted results of the PostScript source code, for direct correspondence between changes to items in the PDF page description and changes to the resulting page appearance.'),
  //                 pw.Bullet(
  //                     text:
  //                         'PDF (from version 1.4) supports graphic transparency; PostScript does not.'),
  //                 pw.Bullet(
  //                     text:
  //                         'PostScript is an interpreted programming language with an implicit global state, so instructions accompanying the description of one page can affect the appearance of any following page. Therefore, all preceding pages in a PostScript document must be processed to determine the correct appearance of a given page, whereas each page in a PDF document is unaffected by the others. As a result, PDF viewers allow the user to quickly jump to the final pages of a long document, whereas a PostScript viewer needs to process all pages sequentially before being able to display the destination page (unless the optional PostScript Document Structuring Conventions have been carefully complied with).'),
  //               ]),
  //           pw.Header(level: 1, text: 'Content'),
  //           pw.Paragraph(
  //               text:
  //                   'A PDF file is often a combination of vector graphics, text, and bitmap graphics. The basic types of content in a PDF are:'),
  //           pw.Bullet(
  //               text:
  //                   'Text stored as content streams (i.e., not encoded in plain text)'),
  //           pw.Bullet(
  //               text:
  //                   'Vector graphics for illustrations and designs that consist of shapes and lines'),
  //           pw.Bullet(
  //               text:
  //                   'Raster graphics for photographs and other types of image'),
  //           pw.Bullet(text: 'Multimedia objects in the document'),
  //           pw.Paragraph(
  //               text:
  //                   'In later PDF revisions, a PDF document can also support links (inside document or web page), forms, JavaScript (initially available as plugin for Acrobat 3.0), or any other types of embedded contents that can be handled using plug-ins.'),
  //           pw.Paragraph(
  //               text:
  //                   'PDF 1.6 supports interactive 3D documents embedded in the PDF - 3D drawings can be embedded using U3D or PRC and various other data formats.'),
  //           pw.Paragraph(
  //               text:
  //                   'Two PDF files that look similar on a computer screen may be of very different sizes. For example, a high resolution raster image takes more space than a low resolution one. Typically higher resolution is needed for printing documents than for displaying them on screen. Other things that may increase the size of a file is embedding full fonts, especially for Asiatic scripts, and storing text as graphics. '),
  //           pw.Header(
  //               level: 1, text: 'File formats and Adobe Acrobat versions'),
  //           pw.Paragraph(
  //               text:
  //                   'The PDF file format has changed several times, and continues to evolve, along with the release of new versions of Adobe Acrobat. There have been nine versions of PDF and the corresponding version of the software:'),
  //           pw.Table.fromTextArray(context: context, data: const <List<String>>[
  //             <String>['Date', 'PDF Version', 'Acrobat Version'],
  //             <String>['1993', 'PDF 1.0', 'Acrobat 1'],
  //             <String>['1994', 'PDF 1.1', 'Acrobat 2'],
  //           ]),
  //           pw.Padding(padding: const pw.EdgeInsets.all(10)),
  //           pw.Paragraph(
  //               text:
  //                   'Text is available under the Creative Commons Attribution Share Alike License.')
  //         ]));

  // return await doc.save();
// }
