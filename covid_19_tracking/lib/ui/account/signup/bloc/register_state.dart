class SignUpState {
  const SignUpState({required this.isValidEmail, required this.isValidPassword, required this.isSubmitting, required this.isSuccess, required this.isFailure});

  //each state is an object, or static object,
  //Can be create by using static/factory method
  factory SignUpState.initial() {
    return const SignUpState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  //Loading state ?
  factory SignUpState.loading() {
    return const SignUpState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  //Failure state ?
  factory SignUpState.failure() {
    return const SignUpState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  //Success state ?
  factory SignUpState.success() {
    return const SignUpState(
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
  SignUpState cloneWith({
    required bool isValidEmail,
    required bool isValidPassword,
    required bool isSubmitting,
    required bool isSuccess,
    required bool isFailure,
  }) {
    return SignUpState(
      isValidEmail: isValidEmail,
      isValidPassword: isValidPassword,
      isSubmitting: isSubmitting,
      isSuccess: isSuccess,
      isFailure: isFailure,
    );
  }

  //How to clone an object and update that object ?
  SignUpState cloneAndUpdate({bool? isValidEmail, bool? isValidPassword}) {
    return cloneWith(
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isValidPassword: isValidPassword ?? this.isValidPassword,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }
}
