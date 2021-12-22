import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid_19_tracking/di/validators.dart';
import 'package:covid_19_tracking/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  //constructor
  LoginBloc({required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(LoginState.initial());
  final UserRepository _userRepository;

  //Give 2 adjacent events a "debounce time"
  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(
    Stream<LoginEvent> loginEvents,
    TransitionFunction<LoginEvent, LoginState> transitionFunction,
  ) {
    final debounceStream = loginEvents.where((loginEvent) {
      return loginEvent is LoginEventEmailChanged || loginEvent is LoginEventPasswordChanged;
    }).debounceTime(const Duration(milliseconds: 50));
    final nonDebounceStream = loginEvents.where((loginEvent) {
      return loginEvent is! LoginEventEmailChanged && loginEvent is! LoginEventPasswordChanged;
    });
    return super.transformEvents(nonDebounceStream.mergeWith([debounceStream]), transitionFunction);
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent loginEvent) async* {
    final loginState = state; //for easier to read code purpose !
    if (loginEvent is LoginEventEmailChanged) {
      yield loginState.cloneAndUpdate(isValidEmail: Validators.isValidEmail(loginEvent.email), isValidPassword: null);
    } else if (loginEvent is LoginEventPasswordChanged) {
      yield loginState.cloneAndUpdate(isValidPassword: Validators.isValidPassword(loginEvent.password), isValidEmail: null);
    }
    if (loginEvent is LoginEventWithGooglePressed) {
      try {
        await _userRepository.signInWithGoogle();
        yield LoginState.success();
      } catch (exception) {
        yield LoginState.failure();
      }
    }
    if (loginEvent is LoginEventWithFacebookPressed) {
      try {
        await _userRepository.signInWithFacebook();
        yield LoginState.success();
      } catch (exception) {
        yield LoginState.failure();
      }
    }
    if (loginEvent is LoginEventWithEmailAndPasswordPressed) {
      try {
        await _userRepository.signInWithEmailAndPassword(loginEvent.email, loginEvent.password);
        yield LoginState.success();
      } catch (_) {
        yield LoginState.failure();
      }
    }
  }
}


