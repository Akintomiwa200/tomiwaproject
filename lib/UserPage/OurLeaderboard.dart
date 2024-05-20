// ignore_for_file: avoid_single_cascade_in_expression_statements, use_build_context_synchronously, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomiwa_project/NetworkPage/NetworkHandler.dart';
import 'package:tomiwa_project/constant/Colors.dart';

import '../NetworkPage/link.dart';
import '../main.dart';

class OurLeaderBoard extends StatefulWidget {
  final ourcosid;
  final cosname;
  const OurLeaderBoard({super.key, this.ourcosid, this.cosname});

  @override
  State<OurLeaderBoard> createState() => _OurLeaderBoardState();
}

class _OurLeaderBoardState extends State<OurLeaderBoard> {
  String ourcosid = '';
  String userid = '';
  @override
  void initState() {
    super.initState();
    ourcosid = widget.ourcosid;

    Future.delayed(Duration.zero, () {
      getResult();
    });
  }

  List<dynamic> mydata = [];
  Crud crud = Crud();
  getResult() async {
    var response = await crud.postRequest(ourleaderboard, {
      "ourcosid": ourcosid,
    });

    // Check if response is not null
    if (response != null) {
      if (response["status"] == "success" &&
          (response["data"] == null || response["data"].isEmpty)) {
        Alert(
          context: context,
          type: AlertType.error,
          title: "Error",
          desc: "You have Not participate in this course",
          buttons: [
            DialogButton(
              onPressed: () => Navigator.pop(context),
              width: 120,
              child: const Text(
                "Ok",
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
              index + 1,
              databoard['percentage'],
              databoard['point'],
              databoard['username'],
            );
          }),
      floatingActionButton: SizedBox(
        height: 80,
        width: 80,
        child: FloatingActionButton(
          tooltip: "long press to check your rank",
          onPressed: () {},
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

  Widget leaderBoardCard(
      int itemNumber, String percent, String point, String username) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(20),
      )),
      color: myPink,
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        title: Text(
          " level $itemNumber, " " username: $username",
          style: const TextStyle(
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
