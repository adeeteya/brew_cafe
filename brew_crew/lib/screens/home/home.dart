import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
                color: Colors.brown[50],
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                child: SettingsForm());
          });
    }

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService().brews,
      catchError: (_, __) => null,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[300],
        appBar: AppBar(
          title: Text("Brew Crew"),
          elevation: 0,
          actions: [
            ElevatedButton.icon(
                icon: Icon(Icons.person),
                onPressed: () async {
                  await _auth.signOut();
                },
                label: Text("Logout")),
            ElevatedButton.icon(
                icon: Icon(Icons.settings),
                onPressed: () {
                  _showSettingsPanel();
                },
                label: Text("Settings")),
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/coffee_bg.png"),
                    fit: BoxFit.cover)),
            child: BrewList()),
      ),
    );
  }
}
