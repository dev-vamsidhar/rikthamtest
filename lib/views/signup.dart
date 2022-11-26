import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riktam/views/login.dart';

import '../controllers/authentication.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  AuthenticationController authcontroller = Get.put(AuthenticationController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Center(
                child: Text(
                  "Create Account",
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 27,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  "create a new account",
                  style: TextStyle(color: Colors.indigo[200]),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: username,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Username"),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.indigo[200],
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Email"),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.indigo[200],
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Password"),
                      prefixIcon: Icon(
                        Icons.password,
                        color: Colors.indigo[200],
                      )),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  authcontroller.signup(
                      email.text, password.text, username.text);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                  onTap: () {
                    Get.to(Login());
                  },
                  child: Text("Already have an account? Login"))
            ],
          ),
        ),
      ),
    );
    ;
  }
}
