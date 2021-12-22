part of 'summary_bloc.dart';

@immutable
abstract class SummaryState extends Equatable {
  const SummaryState();

  @override
  List<Object?> get props => [];
}

class SummaryStateInitial extends SummaryState {}

class SummaryStateLoading extends SummaryState {}

class SummaryStateSuccess extends SummaryState {
  const SummaryStateSuccess({required this.globalSummaryModel});

  final GlobalModel globalSummaryModel;

  @override
  List<Object?> get props => [globalSummaryModel.global, globalSummaryModel.countries];
}

class SummaryStateFailure extends SummaryState {
  const SummaryStateFailure(this.err);

  final Object err;

  @override
  String toString() {
    return err.toString();
  }
}
