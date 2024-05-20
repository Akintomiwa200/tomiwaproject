// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../constant/Colors.dart';

class AdminLogin extends StatefulWidget {
  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  AdminLogin({super.key});

//for signup
  signUp() async {}
  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LogIn Page"),
        centerTitle: true,
        backgroundColor: myPurple,
      ),
      body: Center(
        child: Form(
          key: widget.formstate,
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset(
                    "assets/edu.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                emailField(),
                const SizedBox(height: 20),
                passwordField(),
                const SizedBox(height: 20),
                submit(),
              ],
            ),
          )),
        ),
      ),
    );
  }

  Widget submit() {
    return InkWell(
      onTap: () {
        if (widget.formstate.currentState!.validate()) {}
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: myPink, borderRadius: BorderRadius.circular(20)),
        child: const Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget passwordField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty || value.length < 5) {
          return "password must be more that 5 character";
        }
        return null;
      },
      obscureText: true,
      decoration: InputDecoration(
        label: const Text("Enter Your password"),
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        hintText: "Password",
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "email cant be empty";
        } else if (!value.contains('@')) {
          return 'Email must contain the @ symbol';
        }
        return null;
      },
      decoration: InputDecoration(
        label: const Text("Enter Your email"),
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        hintText: "Email Address",
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
