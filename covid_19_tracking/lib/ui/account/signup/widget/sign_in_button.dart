import 'package:covid_19_tracking/di/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  SignInButton({Key? key, VoidCallback? onPressed})
      : _onPressed = onPressed!,
        super(key: key);
  final VoidCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          primary: bgColor,
        ),
        child: const Text(
          'Sign up ',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        onPressed: () {
          _onPressed();
          //Navigate back
        },
      ),
    );
  }
}
