import 'package:advance_pdf_viewer2/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:tomiwa_project/constant/Colors.dart';

class ViewPqPdfPage extends StatefulWidget {
  final String url;
  final String cosname;
  const ViewPqPdfPage({super.key, required this.url, required this.cosname});

  @override
  State<ViewPqPdfPage> createState() => _ViewPqPdfPageState();
}

class _ViewPqPdfPageState extends State<ViewPqPdfPage> {
  bool isLoading = true;
  late PDFDocument pdfDocument;
  loadPdf() async {
    pdfDocument = await PDFDocument.fromURL(widget.url);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myPurple,
        title: Text(widget.cosname),
        centerTitle: true,
      ),
      body: Center(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : PDFViewer(document: pdfDocument)),
    );
  }
}
