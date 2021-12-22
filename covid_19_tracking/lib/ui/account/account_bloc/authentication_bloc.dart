import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid_19_tracking/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(AuthenticationStateInitial());
  final UserRepository _userRepository;

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AuthenticationEventStarted) {
      try {
        final isSignedIn = await _userRepository.isSignedIn();
        if (isSignedIn) {
          final firebaseUser = await _userRepository.getUser();
          yield AuthenticationStateSuccess(firebaseUser: firebaseUser);
        } else {
          yield const AuthenticationStateFailure('null');
        }
      } catch (e) {
        yield AuthenticationStateFailure(e);
      }
    }
    if (event is AuthenticationEventLoggedIn) {
      yield AuthenticationStateSuccess(firebaseUser: await _userRepository.getUser());
    }
    if (event is AuthenticationEventLoggedOut) {
      _userRepository.signOut();
      yield const AuthenticationStateFailure('null');
    }
  }
}
