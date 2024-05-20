// ignore_for_file: avoid_single_cascade_in_expression_statements, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tomiwa_project/NetworkPage/NetworkHandler.dart';
import 'package:http/http.dart' as http;
import 'package:tomiwa_project/constant/Colors.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../NetworkPage/link.dart';
import '../pdfView/viewpdf.dart';

class AllRegBook extends StatefulWidget {
  const AllRegBook({super.key});

  @override
  State<AllRegBook> createState() => _AllRegBookState();
}

class _AllRegBookState extends State<AllRegBook> {
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
        title: const Text("All Register Book"),
        centerTitle: true,
        backgroundColor: myPurple,
      ),
      body: ListView.builder(
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
            onDelete: () async {
              print(coursebook['id']);

              var response = await crud.postRequest(linkDeleteBook, {
                "id": coursebook['id'].toString(),
              });
              if (response['msg'] == "deleted") {
                Alert(
                  context: context,
                  type: AlertType.success,
                  title: "Success",
                  desc: "File Deleted Successfully",
                  buttons: [
                    DialogButton(
                      onPressed: () => Navigator.pop(context),
                      width: 120,
                      child: const Text(
                        "OK",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  ],
                ).show();

                setState(() {
                  getallBook();
                });
              }
            },
          );
        },
      ),
    );
  }

  Widget allRegBookCard(String title, String book, Function? onTap,
      {required Future<void> Function() onDelete}) {
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
        child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          title: Text(
            "Title: $title",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: const Text(
            "Study Hard for challenge",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              size: 40,
              color: Colors.white,
            ),
            onPressed: onDelete,
          ),
        ),
      ),
    );
  }
}
