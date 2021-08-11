import 'package:brew_crew/models/custom_user.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignIn extends StatefulWidget {
  final Function? toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Sign In",
                    style: TextStyle(fontSize: 36),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          style: TextStyle(color: Color(0xFFEADBCC)),
                          decoration:
                              textInputDecoration.copyWith(hintText: "Email"),
                          validator: (val) =>
                              val!.isEmpty ? "Please Enter the email" : null,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          style: TextStyle(color: Color(0xFFEADBCC)),
                          decoration: textInputDecoration.copyWith(
                              hintText: "Password"),
                          validator: (val) => val!.length < 6
                              ? "Password should contain more than 6 characters"
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        Text(error,
                            style: TextStyle(color: Colors.red, fontSize: 16)),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 50.0,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await _auth
                                  .signInWithEmailAndPass(email, password);
                              if (result.runtimeType != CustomUser) {
                                FirebaseAuthException e = result;
                                setState(() {
                                  error = e.message ?? "Unknown Error occurred";
                                  loading = false;
                                });
                              }
                            }
                          },
                          child: Text("Log In",
                              style: TextStyle(
                                  color: Color(0xFFD4A056), fontSize: 16)),
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFF212325)),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                          onPressed: () {
                            widget.toggleView!();
                          },
                          child: Text("Don't have a account yet?",
                              style: TextStyle(fontSize: 16))),
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
