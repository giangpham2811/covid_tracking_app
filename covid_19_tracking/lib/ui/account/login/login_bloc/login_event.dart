part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEventEmailChanged extends LoginEvent {
  const LoginEventEmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'Email changed: $email';
}

class LoginEventResetPassword extends LoginEvent {
  const LoginEventResetPassword({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class LoginEventPasswordChanged extends LoginEvent {
  const LoginEventPasswordChanged({required this.password});

  final String password;

  //constructor

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'Password changed: $password';
}

//press "Sign in with Google"
class LoginEventWithGooglePressed extends LoginEvent {}

class LoginEventWithFacebookPressed extends LoginEvent {}

class LoginEventWithEmailAndPasswordPressed extends LoginEvent {
  const LoginEventWithEmailAndPasswordPressed({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'LoginEventWithEmailAndPasswordPressed, email = $email, password = $password';
}
