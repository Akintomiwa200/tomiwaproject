// ignore_for_file: avoid_single_cascade_in_expression_statements, use_build_context_synchronously, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomiwa_project/NetworkPage/NetworkHandler.dart';
import 'package:tomiwa_project/constant/Colors.dart';

import '../NetworkPage/link.dart';
import '../main.dart';

class PersonalLeaderBoard extends StatefulWidget {
   final id;
  final cosname;
  const PersonalLeaderBoard({super.key, this.id, this.cosname});

  @override
  State<PersonalLeaderBoard> createState() => _PersonalLeaderBoardState();
}

class _PersonalLeaderBoardState extends State<PersonalLeaderBoard> {
  String cosid = '';
  String userid = '';
  @override
  void initState() {
    super.initState();
    cosid = widget.id;

    Future.delayed(Duration.zero, () {
      getResult();
    });

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        userid = sharedPref.getString('id') ?? '';
      });
    });
  }

  List<dynamic> mydata = [];
  Crud crud = Crud();
  getResult() async {
    var response = await crud.post1Request(myleaderboard, {
      "userid": userid,
      "cosid": cosid,
    });

    // Check if response is not null
    if (response != null) {
      if (response["status"] == "success" &&
          (response["data"] == null || response["data"].isEmpty)) {
            Alert(
      context: context,
      type: AlertType.warning,
      title: "Warning",
      desc: "You Have Not Participated in this Course",
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          width: 120,
          child: const Text(
            "COOL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
       
      }
      if (response["status"] == "success") {
        setState(() {
          mydata = response["data"];
        });
      } else {
        throw Exception('Failed to load data');
      }
    } else {
      print("Response is null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cosname),
        centerTitle: true,
        backgroundColor: myPurple,
      ),
      body: ListView.builder(
          itemCount: mydata.length,
          itemBuilder: (context, index) {
            final databoard = mydata[index];
            return leaderBoardCard(
              databoard['percentage'],
              databoard['point'],
            );
          }),
      floatingActionButton: SizedBox(
        height: 80,
        width: 80,
        child: FloatingActionButton(
          tooltip: "long press to check your rank",
          onPressed: () {
            // Add your floating action button functionality here
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(
                color: Colors.white, width: 10), // Set border color
          ),
          backgroundColor: myPink,
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50,
          decoration: const BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
        ),
      ),
    );
  }

  Widget leaderBoardCard(String percent, String point) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(20),
      )),
      color: myPink,
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        title: const Text(
          "Your Score and point below",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "Score $percent% || $point point",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: const Icon(
          Icons.person,
          size: 60,
          color: Colors.white,
        ),
      ),
    );
  }
}
