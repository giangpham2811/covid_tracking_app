//Now we define BloC
import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpEventEmailChanged extends SignUpEvent {
  const SignUpEventEmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'SignUpEventEmailChanged, email :$email';
}

class SignUpEventPasswordChanged extends SignUpEvent {
  const SignUpEventPasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'SignUpEventPasswordChanged, password: $password';
}

class SignUpEventPressed extends SignUpEvent {
  final String email;
  final String password;

  // ignore: sort_constructors_first
  const SignUpEventPressed({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'SignUpEventPressed, email: $email, password: $password';
  }
}
