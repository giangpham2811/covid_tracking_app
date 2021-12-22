import 'package:covid_19_tracking/di/color.dart';
import 'package:covid_19_tracking/di/constant.dart';
import 'package:covid_19_tracking/ui/account/login/login_bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = GlobalKey<FormState>();

  String? email;
  final TextEditingController _emailController = TextEditingController();
  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
  } //To check fields during submit

  bool checkFields() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset password')),
      body: GestureDetector(
        onTap: () {
          // call this method here to hide soft keyboard
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          color: cardColor,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: formKey,
            child: _buildResetForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildResetForm() {
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: ListView(children: [
          const SizedBox(
            height: 70,
          ),
          SizedBox(
            width: 200,
            height: 200.0,
            child: Image.asset('assets/images/bluezone.png'),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: bgColor),
            ),
            child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(5),
                    icon: const Icon(
                      FontAwesomeIcons.mailBulk,
                      color: bgColor,
                    ),
                    labelText: 'ENTER YOUR EMAIL',
                    labelStyle: TextStyle(fontSize: 15.0, color: Colors.blue.withOpacity(0.5)),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: bgColor),
                    )),
                onChanged: (value) {
                  email = value;
                },
                validator: (value) => value!.isEmpty ? 'Email is required' : validateEmail(value)),
          ),
          const SizedBox(height: 50.0),
          GestureDetector(
            onTap: () {
              _loginBloc.add(LoginEventResetPassword(email: _emailController.text));
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: cardColor,
                    title: const Text('Success'),
                    content: Text('You have success sign up with email is : ${_emailController.text}'),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Ok'))
                    ],
                  );
                },
              );
            },
            child: SizedBox(
              height: 50.0,
              child: Material(
                borderRadius: BorderRadius.circular(25.0),
                shadowColor: Colors.lightBlueAccent,
                color: bgColor,
                elevation: 7.0,
                child: const Center(
                  child: Text(
                    'RESET',
                    style: TextStyle(
                      color: cardColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Go back', style: TextStyle(color: bgColor, decoration: TextDecoration.underline)))
          ])
        ]));
  }
}
