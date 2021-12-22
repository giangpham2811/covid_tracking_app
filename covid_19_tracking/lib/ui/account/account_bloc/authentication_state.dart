part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}
class AuthenticationStateInitial extends AuthenticationState {}

class AuthenticationStateSuccess extends AuthenticationState {
  const AuthenticationStateSuccess({this.firebaseUser});

  @override
  List<Object> get props => [firebaseUser!];

  final User? firebaseUser;

  @override
  String toString() => 'AuthenticationStateSuccess, email: ${firebaseUser!.email}';
}

class AuthenticationStateFailure extends AuthenticationState {
  const AuthenticationStateFailure(this.err);

  final Object err;

  @override
  String toString() {
    return err.toString();
  }
}
