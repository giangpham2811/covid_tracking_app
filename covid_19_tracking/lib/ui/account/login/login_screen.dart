import 'package:covid_19_tracking/di/color.dart';
import 'package:covid_19_tracking/di/constant.dart';
import 'package:covid_19_tracking/repositories/user_repository.dart';
import 'package:covid_19_tracking/ui/account/account_bloc/authentication_bloc.dart';
import 'package:covid_19_tracking/ui/account/login/login_bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required UserRepository userRepository}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late LoginBloc _loginBloc;

  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState loginState) => loginState.isValidEmailAndPassword & isPopulated && !loginState.isSubmitting;

  final formKey = GlobalKey<FormState>();
  String? email, password;

  @override
  void initState() {
    _loginBloc = context.read<LoginBloc>();
    _emailController.addListener(() {
      //when email is changed,this function is called !
      _loginBloc.add(LoginEventEmailChanged(email: _emailController.text));
    });
    _passwordController.addListener(() {
      //when password is changed,this function is called !
      _loginBloc.add(LoginEventPasswordChanged(password: _passwordController.text));
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // call this method here to hide soft keyboard
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (blocContext, state) {
            if (state.isSubmitting) {
              ScaffoldMessenger.of(blocContext).showSnackBar(
                const SnackBar(
                  content: Text('Logging In'),
                ),
              );
            } else if (state.isFailure) {
              ScaffoldMessenger.of(blocContext).showSnackBar(
                const SnackBar(
                  content: Text('Login Failed'),
                ),
              );
            }
          },
          builder: (blocContext, state) {
            if (state.isSuccess) {
              BlocProvider.of<AuthenticationBloc>(blocContext).add(AuthenticationEventLoggedIn());
            }
            return SizedBox(
              height: MediaQuery.of(blocContext).size.height,
              width: MediaQuery.of(blocContext).size.width,
              child: Form(
                key: formKey,
                child: _buildLoginForm(state, blocContext),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoginForm(LoginState state, BuildContext context) {
    return Container(
      color: cardColor,
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: ListView(
        children: [
          const SizedBox(
            height: 20,
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
          const SizedBox(height: 5.0),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.of(context).pushNamed(ResetPasswordViewRoute);
          //     FocusManager.instance.primaryFocus?.unfocus();
          //   },
          //   child: Container(
          //     alignment: Alignment.centerRight,
          //     padding: const EdgeInsets.only(top: 15.0, left: 20.0),
          //     child: const InkWell(
          //       child: Text(
          //         'Forgot Password',
          //         style: TextStyle(color: Colors.white, fontSize: 11.0, decoration: TextDecoration.underline),
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(height: 50.0),
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(height: 50),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              )),
              onPressed: () {
                _loginBloc.add(
                  LoginEventWithEmailAndPasswordPressed(
                    email: _emailController.text,
                    password: _passwordController.text,
                  ),
                );
              },
              child: const Center(
                child: Text(
                  'LOGIN',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(height: 50),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: const BorderSide(color: Colors.red),
                ),
              ),
              onPressed: () {
                BlocProvider.of<LoginBloc>(context).add(LoginEventWithGooglePressed());
              },
              label: const Text(
                'Login with google',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              icon: const Icon(
                FontAwesomeIcons.google,
                color: Colors.red,
              ),
            ),
          ),
          const SizedBox(height: 15),
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(height: 50),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: const BorderSide(color: Colors.blue),
                ),
              ),
              onPressed: () {
                BlocProvider.of<LoginBloc>(context).add(LoginEventWithFacebookPressed());
              },
              label: const Text(
                'Login with facebook',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              icon: const Icon(
                FontAwesomeIcons.facebook,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text('New to Covid-19 Tracker ?'),
            const SizedBox(width: 5.0),
            InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(SignUpViewRoute);
                },
                child: const Text('Register', style: TextStyle(color: bgColor, decoration: TextDecoration.underline)))
          ])
        ],
      ),
    );
  }
}
