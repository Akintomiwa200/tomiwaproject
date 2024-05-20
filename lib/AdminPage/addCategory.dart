// ignore_for_file: use_build_context_synchronously, avoid_single_cascade_in_expression_statements


import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tomiwa_project/NetworkPage/NetworkHandler.dart';
import 'package:tomiwa_project/constant/Colors.dart';

import '../NetworkPage/link.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController category = TextEditingController();
  bool isloading = false;
  Crud crud = Crud();

  addCat() async {
    var response = await crud.postRequest(linkAddCategory, {
      "category": category.text,
    });
    isloading = false;
    if (response["status"] == "category_exist") {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Failed",
        desc: "Category Already Exit",
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
      Alert(
        context: context,
        type: AlertType.info,
        title: "Success",
        desc: "Category registerd successfully",
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Category"),
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
                titleForm(),
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
          isloading = true;
          addCat();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: myPink, borderRadius: BorderRadius.circular(20)),
        child: const Text(
          " Add Category",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget titleForm() {
    return TextFormField(
      controller: category,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Category cant be empty";
        }
        return null;
      },
      decoration: InputDecoration(
        label: const Text("Enter Category"),
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        hintText: "Category",
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
