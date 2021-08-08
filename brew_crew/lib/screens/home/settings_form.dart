import 'package:brew_crew/models/custom_user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4', '5'];
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user?.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
                key: _formkey,
                child: Column(
                  children: [
                    Text("Update your Details", style: TextStyle(fontSize: 18)),
                    SizedBox(height: 20),
                    TextFormField(
                      initialValue: userData?.name,
                      decoration:
                          textInputDecoration.copyWith(hintText: "Name"),
                      validator: (val) =>
                          val!.isEmpty ? "Please Enter a name" : null,
                      onChanged: (val) {
                        setState(() {
                          _currentName = val;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    //dropdown
                    DropdownButtonFormField(
                        decoration: textInputDecoration,
                        value: _currentSugars ?? userData?.sugars,
                        onChanged: (value) {
                          setState(() {
                            _currentSugars = value.toString();
                          });
                        },
                        items: sugars.map((sugar) {
                          return DropdownMenuItem(
                            child: Text("$sugar sugars"),
                            value: sugar,
                          );
                        }).toList()),
                    SizedBox(height: 20),
                    //slider
                    Slider.adaptive(
                        min: 100,
                        max: 900,
                        divisions: 8,
                        activeColor: Colors.brown[
                            _currentStrength ?? (userData!.strength ?? 100)],
                        inactiveColor: Colors.brown[
                            _currentStrength ?? (userData!.strength ?? 100)],
                        value: (_currentStrength ?? userData?.strength)!
                            .toDouble(),
                        onChanged: (val) {
                          setState(() {
                            _currentStrength = val.round();
                          });
                        }),
                    ElevatedButton(
                      child: Text("Update"),
                      style:
                          ElevatedButton.styleFrom(primary: Colors.pink[400]),
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          await DatabaseService(uid: user!.uid).updateUserData(
                              _currentSugars ?? userData!.sugars,
                              _currentName ?? userData!.name,
                              _currentStrength ?? userData!.strength);
                        }
                        Navigator.pop(context);
                      },
                    )
                  ],
                ));
          } else {
            return Loading();
          }
        });
  }
}
