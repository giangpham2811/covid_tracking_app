part of 'summary_bloc.dart';

@immutable
abstract class SummaryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SummaryEventRequested extends SummaryEvent {}

class SummaryEventRefreshed extends SummaryEvent {
  SummaryEventRefreshed(this.globalSummaryModel);

  final GlobalModel globalSummaryModel;

  @override
  List<Object?> get props => [globalSummaryModel.global, globalSummaryModel.countries];
}
