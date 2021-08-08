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
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[300],
            appBar: AppBar(
              title: Text("Sign Up to Brew Crew"),
              elevation: 0,
              actions: [
                ElevatedButton.icon(
                    icon: Icon(Icons.person),
                    onPressed: () {
                      widget.toggleView!();
                    },
                    label: Text("Sign In"))
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: "Email"),
                      validator: (val) =>
                          val!.isEmpty ? "Enter the email" : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
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
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth.registerWithEmailAndPass(
                              email, password);
                          if (result == null) {
                            //couldn't create account
                            setState(() {
                              error = "Enter a Valid Email";
                              loading = false;
                            });
                          }
                        }
                      },
                      child: Text("Register"),
                      style: ElevatedButton.styleFrom(primary: Colors.pink),
                    ),
                    SizedBox(height: 20),
                    Text(error,
                        style: TextStyle(color: Colors.red, fontSize: 14)),
                  ],
                ),
              ),
            ),
          );
  }
}
