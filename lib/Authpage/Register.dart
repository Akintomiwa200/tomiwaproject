import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tomiwa_project/Authpage/Login.dart';

import '../NetworkPage/NetworkHandler.dart';
import '../NetworkPage/link.dart';
import '../constant/Colors.dart';

class RegisterStudentPage extends StatefulWidget {
  const RegisterStudentPage({super.key});

//for signup

  @override
  State<RegisterStudentPage> createState() => _RegisterStudentPageState();
}

class _RegisterStudentPageState extends State<RegisterStudentPage> {
  final Crud crud = Crud();
  bool isLoading = false;
  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController email = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  signUp() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await crud.postRequest(linkSignUp, {
        "fullname": fullname.text,
        "username": username.text,
        "email": email.text,
        "password": password.text
      });
      isLoading = false;
      setState(() {});
      if (response != null && response["status"] == "email_exist") {
        Alert(
          context: (context),
          type: AlertType.error,
          title: "Email Already Exist",
          desc: "This email address has been choosen",
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
      if (response != null && response["status"] == "success") {
        Navigator.push(
            (context),
            MaterialPageRoute(
              builder: (context) => LoginStudent(),
            ));
      } else {
        print(response);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Page"),
        centerTitle: true,
        backgroundColor: myPurple,
      ),
      body: Center(
        child: Form(
          key: formstate,
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
                fullNameField(),
                const SizedBox(height: 20),
                userNameField(),
                const SizedBox(height: 20),
                emailField(),
                const SizedBox(height: 20),
                passwordField(),
                const SizedBox(height: 20),
                submit(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Alreadt have an account",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    MaterialButton(
                      color: myPink,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginStudent(),
                          ),
                        );
                      },
                      child: const Text(
                        "Log in",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
        ),
      ),
    );
  }

  Widget submit() {
    return InkWell(
      onTap: () async {
        signUp();
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: myPink, borderRadius: BorderRadius.circular(20)),
        child: const Text(
          "Register Now",
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
      controller: password,
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
      controller: email,
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

  Widget userNameField() {
    return TextFormField(
      controller: username,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "username cant be empty";
        }
        return null;
      },
      decoration: InputDecoration(
        label: const Text("Enter Your Username"),
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        hintText: "Username",
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget fullNameField() {
    return TextFormField(
      controller: fullname,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "full name cant be empty";
        }
        return null;
      },
      decoration: InputDecoration(
        label: const Text("Enter Your full name"),
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        hintText: "Full namme",
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
