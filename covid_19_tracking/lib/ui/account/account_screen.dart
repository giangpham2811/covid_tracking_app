import 'package:covid_19_tracking/repositories/user_repository.dart';
import 'package:covid_19_tracking/ui/account/account_bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'favorite/favorite_screen.dart';
import 'login/login_bloc/login_bloc.dart';
import 'login/login_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key, required this.userRepository}) : super(key: key);
  final UserRepository userRepository;

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, authenticationState) {
          if (authenticationState is AuthenticationStateSuccess) {
            return const FavoriteScreen();
          }
          if (authenticationState is AuthenticationStateFailure) {
            return BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(userRepository: widget.userRepository),
              child: LoginPage(
                userRepository: widget.userRepository,
              ), //LoginPage,
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
