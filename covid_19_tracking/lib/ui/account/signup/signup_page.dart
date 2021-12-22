import 'package:covid_19_tracking/di/color.dart';
import 'package:covid_19_tracking/repositories/user_repository.dart';
import 'package:covid_19_tracking/ui/account/account_bloc/authentication_bloc.dart';
import 'package:covid_19_tracking/ui/account/signup/bloc/register_bloc.dart';
import 'package:covid_19_tracking/ui/account/signup/bloc/register_event.dart';
import 'package:covid_19_tracking/ui/account/signup/bloc/register_state.dart';
import 'package:covid_19_tracking/ui/account/signup/widget/sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  final UserRepository _userRepository;

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  UserRepository get _userRepository => widget._userRepository;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isSignUpButtonEnabled(SignUpState state) {
    return state.isValidEmailAndPassword && isPopulated && !state.isSubmitting;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SignUp')),
      body: GestureDetector(
        onTap: () {
          // call this method here to hide soft keyboard
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
          child: BlocProvider<SignUpBloc>(
            create: (context) => SignUpBloc(userRepository: _userRepository),
            child: BlocBuilder<SignUpBloc, SignUpState>(
              builder: (blocContext, state) {
                if (state.isFailure) {
                  print('Registration Failed');
                } else if (state.isSubmitting) {
                  print('Registration in progress...');
                } else if (state.isSuccess) {
                  BlocProvider.of<AuthenticationBloc>(blocContext).add(AuthenticationEventLoggedIn());
                }
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: cardColor,
                  child: ListView(
                    children: <Widget>[
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
                            contentPadding: const EdgeInsets.all(2),
                            icon: const Icon(
                              Icons.email,
                              color: bgColor,
                            ),
                            labelText: 'Enter your email',
                            labelStyle: TextStyle(
                              fontSize: 15.0,
                              color: Colors.blue.withOpacity(0.5),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: bgColor),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          autocorrect: false,
                          validator: (_) {
                            return state.isValidEmail ? null : 'Invalid email format';
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: bgColor),
                        ),
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(2),
                              icon: const Icon(
                                Icons.lock,
                                color: bgColor,
                              ),
                              labelText: 'Enter your password',
                              labelStyle: TextStyle(
                                fontSize: 15.0,
                                color: Colors.blue.withOpacity(0.5),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: bgColor),
                              )),
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          autocorrect: false,
                          validator: (_) {
                            return state.isValidPassword ? null : 'Invalid password format';
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),
                      SignInButton(onPressed: () {
                        if (isSignUpButtonEnabled(state)) {
                          BlocProvider.of<SignUpBloc>(blocContext).add(
                            SignUpEventPressed(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                          );
                          showDialog(
                            barrierDismissible: false,
                            context: blocContext,
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
                        } else {
                          showDialog(
                            context: blocContext,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: cardColor,
                                title: const Text('Alert'),
                                content: const Text('Email or password is not valid'),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Ok'))
                                ],
                              );
                            },
                          );
                        }
                      }),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
