// ignore_for_file: avoid_single_cascade_in_expression_statements, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tomiwa_project/NetworkPage/NetworkHandler.dart';
import 'package:http/http.dart' as http;
import 'package:tomiwa_project/constant/Colors.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../NetworkPage/link.dart';
import '../pdfView/viewpdf.dart';

class ReadBook extends StatefulWidget {
  const ReadBook({super.key});

  @override
  State<ReadBook> createState() => _ReadBookState();
}

class _ReadBookState extends State<ReadBook> {
  List<dynamic> studentData = [];

  @override
  void initState() {
    super.initState();
    getallBook();
  }

  Crud crud = Crud();
  Future<void> getallBook() async {
    final response = await http.get(Uri.parse(linkgetBook));

    if (response.statusCode == 200) {
      setState(() {
        studentData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Select Book and Read"),
          centerTitle: true,
          backgroundColor: myPurple,
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: studentData.length,
          itemBuilder: (context, index) {
            final coursebook = studentData[index];
            return allRegBookCard(
              coursebook['title'],
              coursebook['book'],
              () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewPqPdfPage(
                        cosname: coursebook['title'],
                        url: linkPdfRoot + coursebook['book'],
                      ),
                    ));
              },
            );
          },
        ));
  }

  Widget allRegBookCard(String title, String book, Function? onTap) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(20),
        )),
        color: myPink,
        child: Column(
          children: [
            const Icon(
              Icons.book,
              size: 100,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
