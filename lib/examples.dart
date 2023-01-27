import 'dart:async';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';

import 'examples/leonel.dart';
import 'examples/raul.dart';
import 'examples/ariel.dart';

const examples = <Example>[
  Example('HV Leonel', 'document1.dart', generateLeonel),
  Example('HV Raul', 'document2.dart', generateRaul),
  Example('HV Ariel', 'document3.dart', generateAriel),
];

typedef LayoutCallbackWithData = Future<Uint8List> Function(
    PdfPageFormat pageFormat);

class Example {
  const Example(this.name, this.file, this.builder);

  final String name;

  final String file;

  final LayoutCallbackWithData builder;
}
