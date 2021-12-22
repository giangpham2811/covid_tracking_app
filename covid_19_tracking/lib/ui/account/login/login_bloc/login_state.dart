part of 'login_bloc.dart';

@immutable
class LoginState {
  const LoginState({required this.isValidEmail, required this.isValidPassword, required this.isSubmitting, required this.isSuccess, required this.isFailure});

  //each state is an object, or static object,
  //Can be create by using static/factory method
  factory LoginState.initial() {
    return const LoginState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  //Loading state ?
  factory LoginState.loading() {
    return const LoginState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  //Failure state ?
  factory LoginState.failure() {
    return const LoginState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  //Success state ?
  factory LoginState.success() {
    return const LoginState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  final bool isValidEmail;
  final bool isValidPassword;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isValidEmailAndPassword => isValidEmail && isValidPassword;

  //do the same with RegisterState
  //constructor

  //Clone an object of LoginState?
  LoginState cloneWith({
    required bool isValidEmail,
    required bool isValidPassword,
    required bool isSubmitting,
    required bool isSuccess,
    required bool isFailure,
  }) {
    return LoginState(
      isValidEmail: isValidEmail,
      isValidPassword: isValidPassword,
      isSubmitting: isSubmitting,
      isSuccess: isSuccess,
      isFailure: isFailure,
    );
  }

  //How to clone an object and update that object ?
  LoginState cloneAndUpdate({bool? isValidEmail, bool? isValidPassword}) {
    return cloneWith(
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isValidPassword: isValidPassword ?? this.isValidPassword,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }
}
