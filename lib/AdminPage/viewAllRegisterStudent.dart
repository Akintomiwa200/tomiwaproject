import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tomiwa_project/NetworkPage/NetworkHandler.dart';
import 'package:http/http.dart' as http;
import 'package:tomiwa_project/constant/Colors.dart';

import '../NetworkPage/link.dart';

class AllRegStudent extends StatefulWidget {
  const AllRegStudent({super.key});

  @override
  State<AllRegStudent> createState() => _AllRegStudentState();
}

class _AllRegStudentState extends State<AllRegStudent> {
  List<dynamic> studentData = [];

  @override
  void initState() {
    super.initState();
    getallStudent();
  }

  Crud crud = Crud();
  Future<void> getallStudent() async {
    final response = await http.get(Uri.parse(linkgetStudent));

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
        title: const Text("All Register Student"),
        centerTitle: true,
        backgroundColor: myPurple,
      ),
      body: ListView.builder(
        itemCount: studentData.length,
        itemBuilder: (context, index) {
          final student = studentData[index];
          return allRegStudentCard(
            student['fullname'],
            student['email'],
          );
        },
      ),
    );
  }

  Widget allRegStudentCard(String fullname, String email) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(20),
      )),
      color: myPink,
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        title: Text(
          "fullname: $fullname",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "Email: $email",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: const Icon(
          Icons.delete,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
