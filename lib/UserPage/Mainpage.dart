// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomiwa_project/Authpage/Login.dart';
import 'package:tomiwa_project/UserPage/Feedback.dart';
import 'package:tomiwa_project/constant/Colors.dart';

import '../main.dart';
import 'LeaderBoardPage.dart';
import 'QuizPage/SelectQuiz.dart';
import 'QuizPage/ourLeaderboardcategory.dart';
import 'ReadBook.dart';

class StudentMainPage extends StatefulWidget {
  const StudentMainPage({super.key});

  @override
  State<StudentMainPage> createState() => _StudentMainPageState();
}

class _StudentMainPageState extends State<StudentMainPage> {
  String username = '';
  String fullname = '';
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        username = sharedPref.getString('username') ?? '';
        fullname = sharedPref.getString('fullname') ?? 'nothing found';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome: $username"),
        centerTitle: true,
        backgroundColor: myPurple,
      ),
      drawer: Drawer(
        backgroundColor: myPurple,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  child: Image.asset(
                    'assets/man-2.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "username: $username",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "fullname: $fullname",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                InkWell(
                  onTap: () {
                    sharedPref.clear();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginStudent()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    color: myPink,
                    child: const Text(
                      "logout",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              readBook(),
              const SizedBox(height: 20),
              takeQuiz(),
              const SizedBox(height: 20),
              dashboard(),
              const SizedBox(height: 20),
              ourLeaderBoard(),
              // const SizedBox(height: 20),
              // community(),
              const SizedBox(height: 20),
              feedback()
            ],
          ),
        ),
      ),
    );
  }

  Widget takeQuiz() {
    return InkWell(
      onTap: () {
        Alert(
          context: context,
          type: AlertType.warning,
          title: "Warning ",
          desc: "Are You Sure You Are Ready For This",
          buttons: [
            DialogButton(
              onPressed: () => Navigator.pop(context),
              color: Colors.red,
              child: const Text(
                "NO",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            DialogButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelectQuizCategory(),
                    ));
              },
              gradient: const LinearGradient(colors: [
                Color.fromRGBO(116, 116, 191, 1.0),
                Color.fromRGBO(52, 138, 199, 1.0)
              ]),
              child: const Text(
                "Yes",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ).show();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: myPink,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: const [
            Icon(
              Icons.quiz_sharp,
              size: 125,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              "Take Quiz",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget feedback() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, ((MaterialPageRoute(builder: ((context) => FeedBack())))));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: myPink,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: const [
            Icon(
              Icons.feedback_outlined,
              size: 125,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              "Give Feedback",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget community() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: myPink,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: const [
            Icon(
              Icons.group,
              size: 125,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              "Engage in a community",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget readBook() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            ((MaterialPageRoute(
              builder: (context) => const ReadBook(),
            ))));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: myPink,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: const [
            Icon(
              Icons.school_sharp,
              size: 125,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              "Read Book",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ourLeaderBoard() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            ((MaterialPageRoute(
              builder: (context) => const OurLeaderBoardCategory(),
            ))));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: myPink,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: const [
            Icon(
              Icons.dashboard,
              size: 125,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              "Check Leaderboard",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dashboard() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            ((MaterialPageRoute(
              builder: (context) => const LeaderBoardPage(),
            ))));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: myPink,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.reviews_sharp,
              size: 125,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                "My Score and Point",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
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
