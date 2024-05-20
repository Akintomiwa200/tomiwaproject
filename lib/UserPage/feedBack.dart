// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tomiwa_project/constant/Colors.dart';

class FeedBack extends StatefulWidget {
  GlobalKey<FormState> formstate = GlobalKey();
  FeedBack({super.key});

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Course"),
        centerTitle: true,
        backgroundColor: myPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Form(
            key: widget.formstate,
            child: Column(
              children: [
                const SizedBox(height: 10),
                titleForm(),
                const SizedBox(height: 20),
                bodyForm(),
                const SizedBox(height: 20),
                submit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget submit() {
    return InkWell(
      onTap: () {
        if (widget.formstate.currentState!.validate()) {
          Alert(
      context: context,
      type: AlertType.success,
      title: "Success",
      desc: "Your Report have been Submitted.",
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          width: 120,
          child:const  Text(
            "COOL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: myPink, borderRadius: BorderRadius.circular(20)),
        child: const Text(
          "Submit Feedback",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget bodyForm() {
    return TextFormField(
      maxLines: 10,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Body cant be empty";
        }
        return null;
      },
      decoration: InputDecoration(
        label: const Text("Enter Description"),
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        hintText: "Enter Description",
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget titleForm() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Title cant be empty";
        }
        return null;
      },
      decoration: InputDecoration(
        label: const Text("Enter Title"),
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        hintText: "Title",
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
