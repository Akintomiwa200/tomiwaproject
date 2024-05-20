// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, avoid_single_cascade_in_expression_statements

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomiwa_project/NetworkPage/NetworkHandler.dart';
import 'package:tomiwa_project/constant/Colors.dart';
import '../../NetworkPage/link.dart';
import '../../main.dart';
import '../Mainpage.dart';

class QuizQuestion extends StatefulWidget {
  final String id;
  final cosname;

  const QuizQuestion({Key? key, required this.id, this.cosname})
      : super(key: key);

  @override
  State<QuizQuestion> createState() => _QuizQuestionState();
}

class _QuizQuestionState extends State<QuizQuestion> {
  bool isLoading = false;
  late String cos_id = '';
  Map<int, String?> selectedAnswersMap = {};
  List<Map<String, dynamic>> questions = [];
  String userid = '';
  String myusername = '';
  @override
  void initState() {
    super.initState();
    cos_id = widget.id;
    getQuizQuestion();

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        userid = sharedPref.getString('id') ?? '';
        myusername = sharedPref.getString('username') ?? '';
      });
    });
  }

  Crud crud = Crud();

  getQuizQuestion() async {
    var response = await crud.postRequest(linkgetQuestion, {
      "cos_id": cos_id,
    });
    if (response["status"] == "success") {
      if (response["questions"] != null &&
          (response["questions"] as List).isNotEmpty) {
        setState(() {
          questions = List<Map<String, dynamic>>.from(response["questions"]);
        });
      } else {
        Alert(
          context: context,
          type: AlertType.warning,
          title: "No Question Yet",
          desc: "There is no Question for this Course Now\n Come Back Later",
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
      }
    } else {
      // print("no Internet connection");
    }
  }

  Future<void> submitAnswers() async {
    setState(() {
      isLoading = true;
    });
    if (questions != null && questions.isNotEmpty) {
      List<List<String>> answersList = [];
      for (int i = 0; i < questions.length; i++) {
        Map<String, dynamic> question = questions[i];
        String questionID = question['id'].toString();
        String selectedAnswer = selectedAnswersMap[i + 1] ?? "";
        String realAnswer = question['answer'].toString();
        String category = question['category'].toString();
        String cos_id = widget.id;
        String userId = userid;

        answersList.add([
          questionID,
          selectedAnswer,
          realAnswer,
          category,
          cos_id,
          userId,
        ]);
      }
      Map<String, List<List<String>>> postData = {"answers": answersList};

      Crud crud = Crud();
      var response = await crud.post2Request(linkSubmitAnswers, postData);

      if (response != null) {
        if (response is Map<String, dynamic>) {
          // Handle successful response
          if (response.containsKey("status")) {
            String status = response["status"];
            if (status == "success") {
              Alert(
                context: context,
                type: AlertType.error,
                title: "Success",
                desc: "Answer Submitted Successfully",
                buttons: [
                  DialogButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const StudentMainPage())));
                    },
                    width: 120,
                    child: const Text(
                      "COOL",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ],
              ).show();
            } else {
              print("Failed to submit answers. Status: $status");
            }
          }
        }
      }
    }
  }

  Future<void> calculateAnswer() async {
    var response = await crud.postRequest(oneleaderboard, {
      "cos_id": cos_id,
      "userid": userid,
      "myusername": myusername,
    });

    if (response != null && response["status"] != null) {
      if (response["status"] == "success") {
        print("data inserted");
      } else {
        print("Failed to insert data. Status: ${response["status"]}");
      }
    } else {
      print("Invalid or empty response");
    }
  }

  Future<void> submitAnswersAndCalculate() async {
    // Submit answers
    await submitAnswers();

    // Calculate answers
    await calculateAnswer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cosname),
        backgroundColor: myPurple,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < questions.length; i++)
              buildQuestionCard(questions[i], i + 1),
            ElevatedButton(
              onPressed: () {
                submitAnswersAndCalculate();
              },
              child: const Text('Submit Answers'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildQuestionCard(Map<String, dynamic> question, int questionNumber) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "$questionNumber. ${question["question"]}",
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          buildOptionRadioButtons(question, questionNumber),
        ],
      ),
    );
  }

  Widget buildOptionRadioButtons(
      Map<String, dynamic> question, int questionNumber) {
    return Column(
      children: ['optiona', 'optionb', 'optionc', 'optiond'].map((optionKey) {
        return RadioListTile<String?>(
          title: Text(question[optionKey]),
          value: question[optionKey],
          groupValue: selectedAnswersMap[questionNumber],
          onChanged: (String? value) {
            setState(() {
              selectedAnswersMap[questionNumber] = value;
              print(selectedAnswersMap);
            });
          },
        );
      }).toList(),
    );
  }
}
