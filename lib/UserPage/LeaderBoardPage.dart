import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tomiwa_project/NetworkPage/NetworkHandler.dart';
import 'package:http/http.dart' as http;
import 'package:tomiwa_project/constant/Colors.dart';

import '../../NetworkPage/link.dart';
import 'PersonalLeaderboard.dart';

class LeaderBoardPage extends StatefulWidget {
  const LeaderBoardPage({super.key});

  @override
  State<LeaderBoardPage> createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
  List<dynamic> quizData = [];

  @override
  void initState() {
    super.initState();
    quizCategory();
  }

  Crud crud = Crud();
  Future<void> quizCategory() async {
    final response = await http.get(Uri.parse(linkgetCategory));

    if (response.statusCode == 200) {
      setState(() {
        quizData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Know Your Rank"),
        centerTitle: true,
        backgroundColor: myPurple,
      ),
      body: ListView.builder(
        itemCount: quizData.length,
        itemBuilder: (context, index) {
          final quiz = quizData[index];
          return InkWell(
            onTap: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonalLeaderBoard(
                      cosname: quiz['category'],
                      id: quiz['id'],
                    ),
                  ));
            },
            child: allRegQuizCard(
              quiz['category'],
              quiz['id'],
            ),
          );
        },
      ),
    );
  }

  Widget allRegQuizCard(String title, String id) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(20),
      )),
      color: myPink,
      child: ListTile(
        contentPadding: const EdgeInsets.all(30),
        title: Text(
          "Course: $title",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
