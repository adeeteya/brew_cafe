import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFEADBCC),
      child: Center(
          child: Lottie.asset("assets/coffeloading.json",
              width: 400, height: 400, fit: BoxFit.cover)),
    );
  }
}
