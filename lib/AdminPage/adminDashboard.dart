import 'package:flutter/material.dart';
import 'package:tomiwa_project/constant/Colors.dart';

import '../Authpage/Login.dart';
import '../UserPage/LeaderBoardPage.dart';
import '../main.dart';
import 'aRegStu.dart';
import 'addBook.dart';
import 'addCategory.dart';
import 'addQuizQuestion.dart';
import 'viewAllRegisterStudent.dart';
import 'viewallregisteredBook.dart';

class AdminDashBoard extends StatefulWidget {
  const AdminDashBoard({super.key});

  @override
  State<AdminDashBoard> createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin DashBoard"),
        centerTitle: true,
        backgroundColor: myPurple,
        leading: InkWell(
          onTap: () {
            sharedPref.clear();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginStudent()));
          },
          child: const Icon(
            Icons.logout,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              addBook(),
              const SizedBox(height: 20),
              vRegBook(),
              const SizedBox(height: 20),
              addCat(),
              const SizedBox(height: 20),
              quizQuestion(),
              const SizedBox(height: 20),
              registerStudent(),
              const SizedBox(height: 20),
              registeredUsers(),
              const SizedBox(height: 20),
              // dashboard()
            ],
          ),
        ),
      ),
    );
  }

  Widget vRegBook() {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            ((MaterialPageRoute(builder: ((context) => const AllRegBook())))));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: myPink,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(15),
        child: const Column(
          children: [
            Icon(
              Icons.view_list,
              size: 125,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              "View all Book",
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

  Widget addCat() {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            ((MaterialPageRoute(builder: ((context) => const AddCategory())))));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: myPink,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(15),
        child: const Column(
          children: [
            Icon(
              Icons.category,
              size: 125,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              "Add Category",
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

  Widget quizQuestion() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            ((MaterialPageRoute(
                builder: ((context) => const AddQuizQuestion())))));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: myPink,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(15),
        child: const Column(
          children: [
            Icon(
              Icons.question_answer,
              size: 125,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              "Add Quiz Question and answer",
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

  Widget addBook() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            ((MaterialPageRoute(
                builder: ((context) => const FileUploadForm())))));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: myPink,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(15),
        child: const Column(
          children: [
            Icon(
              Icons.book,
              size: 125,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              "Add Book",
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

  Widget registerStudent() {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ARegisterStudentPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: myPink,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(15),
        child: const Column(
          children: [
            Icon(
              Icons.person_2,
              size: 125,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              "Register a Student",
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

  Widget registeredUsers() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            ((MaterialPageRoute(
              builder: (context) => const AllRegStudent(),
            ))));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: myPink,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(15),
        child: const Column(
          children: [
            Icon(
              Icons.people,
              size: 125,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              "All Registered Users",
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
        child: const Column(
          children: [
            Icon(
              Icons.dashboard,
              size: 125,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              "Leaders Board",
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
}
