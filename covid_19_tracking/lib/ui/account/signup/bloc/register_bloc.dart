import 'package:covid_19_tracking/di/validators.dart';
import 'package:covid_19_tracking/repositories/user_repository.dart';
import 'package:covid_19_tracking/ui/account/signup/bloc/register_event.dart';
import 'package:covid_19_tracking/ui/account/signup/bloc/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(SignUpState.initial());
  final UserRepository _userRepository;

  @override
  Stream<Transition<SignUpEvent, SignUpState>> transformEvents(
    Stream<SignUpEvent> events,
    TransitionFunction<SignUpEvent, SignUpState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return event is! SignUpEventEmailChanged && event is! SignUpEventPasswordChanged;
    });
    final debounceStream = events.where((event) {
      return event is SignUpEventEmailChanged || event is SignUpEventPasswordChanged;
    }).debounceTime(const Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent signUpEvent) async* {
    if (signUpEvent is SignUpEventEmailChanged) {
      yield state.cloneAndUpdate(
        isValidEmail: Validators.isValidEmail(signUpEvent.email),
      );
    } else if (signUpEvent is SignUpEventPasswordChanged) {
      yield state.cloneAndUpdate(
        isValidPassword: Validators.isValidPassword(signUpEvent.password),
      );
    } else if (signUpEvent is SignUpEventPressed) {
      yield SignUpState.loading();
      try {
        await _userRepository.signUpWithEmailAndPassword(
          signUpEvent.email,
          signUpEvent.password,
        );
        yield SignUpState.success();
      } catch (exception) {
        yield SignUpState.failure();
      }
    }
  }
}
