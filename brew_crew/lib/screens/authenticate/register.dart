import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function? toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  String name = "New Crew Member";
  final List<String> sugarsList = ['0', '1', '2', '3', '4', '5'];
  String sugars = '0';
  int strength = 100;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color(0xFFEADBCC),
            appBar: AppBar(
              title: RichText(
                text: TextSpan(
                    style: TextStyle(fontSize: 40, fontFamily: 'LouizeDisplay'),
                    children: [
                      TextSpan(
                          text: "Brew",
                          style: TextStyle(color: Color(0xFF212325))),
                      TextSpan(
                          text: "café",
                          style: TextStyle(color: Color(0xFFD4A056)))
                    ]),
              ),
              centerTitle: true,
              elevation: 0,
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text(error,
                          style: TextStyle(color: Colors.red, fontSize: 14)),
                      SizedBox(height: 20),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        style: TextStyle(color: Color(0xFFEADBCC)),
                        decoration:
                            textInputDecoration.copyWith(hintText: "Name"),
                        validator: (val) =>
                            val!.isEmpty ? "Please Enter your name" : null,
                        onChanged: (val) {
                          setState(() {
                            name = val;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        style: TextStyle(color: Color(0xFFEADBCC)),
                        decoration:
                            textInputDecoration.copyWith(hintText: "Email"),
                        validator: (val) =>
                            val!.isEmpty ? "Enter a valid email" : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        style: TextStyle(color: Color(0xFFEADBCC)),
                        decoration:
                            textInputDecoration.copyWith(hintText: "Password"),
                        validator: (val) =>
                            val!.length < 6 ? "Password too short" : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(color: Color(0xFFEADBCC)),
                        decoration: textInputDecoration.copyWith(
                            hintText: "Re-Enter Password"),
                        validator: (val) => val?.compareTo(password) != 0
                            ? "Passwords Don't match"
                            : null,
                        obscureText: true,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth
                                .registerWithEmailAndPass(email, password,
                                    name: name);
                            if (result == null) {
                              //couldn't create account
                              setState(() {
                                error = "Enter a Valid Email";
                                loading = false;
                              });
                            }
                          }
                        },
                        child: Text("Create a Account",
                            style: TextStyle(color: Color(0xFFD4A056))),
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xFF212325)),
                      ),
                      SizedBox(height: 5),
                      TextButton(
                          onPressed: () {
                            widget.toggleView!();
                          },
                          child: Text("Already have a account?",
                              style: TextStyle(fontSize: 16)))
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
