import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
                color: Color(0xFFEADBCC),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: SettingsForm());
          });
    }

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService().brews,
      catchError: (_, __) => null,
      initialData: null,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: RichText(
            text: TextSpan(
                style: TextStyle(fontSize: 40, fontFamily: 'LouizeDisplay'),
                children: [
                  TextSpan(
                      text: "Brew", style: TextStyle(color: Color(0xFF212325))),
                  TextSpan(
                      text: "café", style: TextStyle(color: Color(0xFFD4A056)))
                ]),
          ),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                _showSettingsPanel();
              },
              icon: Icon(Icons.settings, color: Colors.black),
            ),
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
