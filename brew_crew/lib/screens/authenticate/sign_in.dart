import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(error,
                        style: TextStyle(color: Colors.red, fontSize: 16)),
                    SizedBox(height: 20),
                    TextFormField(
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
                      decoration:
                          textInputDecoration.copyWith(hintText: "Password"),
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
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth.signInWithEmailAndPass(
                              email, password);
                          if (result == null) {
                            setState(() {
                              error = "Invalid Credentials,Please Try Again";
                              loading = false;
                            });
                          }
                        }
                      },
                      child: Text("Log In",
                          style: TextStyle(color: Color(0xFFD4A056))),
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xFF212325)),
                    ),
                    SizedBox(height: 5),
                    TextButton(
                        onPressed: () {
                          widget.toggleView!();
                        },
                        child: Text("Don't have a account yet?",
                            style: TextStyle(fontSize: 16)))
                  ],
                ),
              ),
            ),
          );
  }
}
