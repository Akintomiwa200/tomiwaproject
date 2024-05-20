import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tomiwa_project/AdminPage/adminDashboard.dart';
import 'package:tomiwa_project/NetworkPage/NetworkHandler.dart';
import 'package:tomiwa_project/constant/Colors.dart';

import '../NetworkPage/link.dart';

class AddQuizQuestion extends StatefulWidget {
  const AddQuizQuestion({super.key});

  @override
  State<AddQuizQuestion> createState() => _AddQuizQuestionState();
}

class _AddQuizQuestionState extends State<AddQuizQuestion> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController question = TextEditingController();
  TextEditingController optiona = TextEditingController();
  TextEditingController optionb = TextEditingController();
  TextEditingController optionc = TextEditingController();
  TextEditingController optiond = TextEditingController();
  TextEditingController answer = TextEditingController();
//for getting category
  String? selectedCategory;
  bool loading = false;
  List categoryList = [];
  Future getCategory() async {
    var uri =
        Uri.parse("http://192.168.110.47/tomiwaquiz/quiz/getcategory.php");
    var response = await http.get(
      uri,
      headers: {"Accept": "application/json"},
    );
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    setState(() {
      categoryList = jsonData;
    });
  }

  Crud crud = Crud();
  submitQuestion() async {
    var response = await crud.postRequest(linkPostQuestion, {
      "question": question.text,
      "optiona": optiona.text,
      "optionb": optionb.text,
      "optionc": optionc.text,
      "optiond": optiond.text,
      "answer": answer.text,
      "category": selectedCategory,
    });
    loading = false;
    if (response["status"] == "success") {
      Alert(
        context: (context),
        type: AlertType.error,
        title: "Sccuess",
        desc: "Question Added Successfully",
        buttons: [
          DialogButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminDashBoard(),
                  ));
            },
            width: 120,
            child: const Text(
              "COOL",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ).show();
    }
  }

  @override
  void initState() {
    super.initState();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Quiz Question"),
        centerTitle: true,
        backgroundColor: myPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Form(
            key: formstate,
            child: Column(
              children: [
                const SizedBox(height: 10),
                questionForm(),
                const SizedBox(height: 20),
                selectCat(),
                const SizedBox(height: 20),
                optionAForm(),
                const SizedBox(height: 20),
                optionBForm(),
                const SizedBox(height: 20),
                optionCForm(),
                const SizedBox(height: 20),
                optionDForm(),
                const SizedBox(height: 20),
                answerOption(),
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
        if (formstate.currentState!.validate()) {
          loading = true;
          submitQuestion();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: myPink, borderRadius: BorderRadius.circular(20)),
        child: const Text(
          "Submit Question",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget questionForm() {
    return TextFormField(
      controller: question,
      maxLines: 5,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Question cant be empty";
        }
        return null;
      },
      decoration: InputDecoration(
        label: const Text("Enter Question"),
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        hintText: "Enter Question",
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget optionAForm() {
    return TextFormField(
      controller: optiona,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Option A cant be empty";
        }
        return null;
      },
      decoration: InputDecoration(
        label: const Text("Enter Option A "),
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        hintText: "Option A",
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget optionBForm() {
    return TextFormField(
      controller: optionb,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Option B cant be empty";
        }
        return null;
      },
      decoration: InputDecoration(
        label: const Text("Enter Option B "),
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        hintText: "Option B",
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget optionCForm() {
    return TextFormField(
      controller: optionc,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Option C cant be empty";
        }
        return null;
      },
      decoration: InputDecoration(
        label: const Text("Enter Option C "),
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        hintText: "Option C",
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget optionDForm() {
    return TextFormField(
      controller: optiond,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Option D cant be empty";
        }
        return null;
      },
      decoration: InputDecoration(
        label: const Text("Enter Option D"),
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        hintText: "Option D",
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget answerOption() {
    return TextFormField(
      controller: answer,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Answer cant be empty";
        }
        return null;
      },
      decoration: InputDecoration(
        label: const Text("Enter Answer "),
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        hintText: "Answer",
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget selectCat() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 0.5)),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      child: DropdownButton(
        value: selectedCategory,
        isExpanded: true,
        hint: const Text("Select the Category"),
        items: categoryList.map((list) {
          return DropdownMenuItem(
            value: list['id'],
            child: Text(list['category']),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedCategory = value as String?;
          });
        },
      ),
    );
  }
}
