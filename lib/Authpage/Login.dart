import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tomiwa_project/Authpage/Register.dart';
import 'package:tomiwa_project/NetworkPage/NetworkHandler.dart';
import 'package:tomiwa_project/UserPage/Mainpage.dart';
import '../NetworkPage/link.dart';
import '../constant/Colors.dart';
import '../main.dart';
import 'Adminlogin.dart';

class LoginStudent extends StatefulWidget {
  const LoginStudent({super.key});

//for signup
  signUp() async {}
  @override
  State<LoginStudent> createState() => _LoginStudentState();
}

class _LoginStudentState extends State<LoginStudent> {
  GlobalKey<FormState> loformstate = GlobalKey();
  GlobalKey<FormFieldState<String>> emailKey = GlobalKey();
  GlobalKey<FormFieldState<String>> passwordKey = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;
  Crud crud = Crud();
  login() async {
    var response = await crud.postRequest(linkLogin, {
      "email": email.text,
      "password": password.text,
    });
    isLoading = false;
    setState(() {});
    if (response != null && response["status"] == "login_successfull") {
      sharedPref.setString("fullname", response["user_data"]["fullname"]);
      sharedPref.setString("id", response["user_data"]["id"].toString());
      sharedPref.setString("username", response["user_data"]["username"]);
      sharedPref.setString("email", response["user_data"]["email"]);
      Navigator.pushAndRemoveUntil(
          (context),
          MaterialPageRoute(builder: (context) => const StudentMainPage()),
          (route) => false);
    } else {
      Alert(
        context: (context),
        type: AlertType.error,
        title: "Error",
        desc: "Invalid Email or Password",
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
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
        centerTitle: true,
        backgroundColor: myPurple,
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: loformstate,
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
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Don't have an account",
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
                            builder: (context) => const RegisterStudentPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "register here",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Alogin()));
                  },
                  child: const Text("Admin Login",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget submit() {
    return InkWell(
      onTap: () {
        if (loformstate.currentState!.validate()) {
          isLoading = true;
          setState(() {});
          login();
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: myPink, borderRadius: BorderRadius.circular(20)),
        child: const Center(
          child: Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget passwordField() {
    return TextFormField(
      key: passwordKey,
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
      key: emailKey,
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
}
