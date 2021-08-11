import 'package:brew_crew/models/brew.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatelessWidget {
  final Brew? brew;
  BrewTile({this.brew});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: ListTile(
            leading: CircleAvatar(
                backgroundImage: AssetImage("assets/coffee_icon.png"),
                radius: 25,
                backgroundColor: Colors.brown[brew?.strength ?? 100]),
            title: Text(brew?.name ?? ""),
            subtitle: (brew?.sugars == '0')
                ? Text("Does not take Sugar")
                : (brew?.sugars == '1')
                    ? Text("Takes 1 packet of sugar")
                    : Text("Takes ${brew?.sugars ?? '0'} packets of sugar"),
          ),
        ));
  }
}
