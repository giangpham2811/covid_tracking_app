import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid_19_tracking/model/global_summary/global_summary_model.dart';
import 'package:covid_19_tracking/repositories/global_summary_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'summary_event.dart';
part 'summary_state.dart';

class SummaryBloc extends Bloc<SummaryEvent, SummaryState> {
  SummaryBloc(this.globalSummaryRepository) : super(SummaryStateInitial());
  final GlobalSummaryRepository globalSummaryRepository;

  @override
  Stream<SummaryState> mapEventToState(SummaryEvent event) async* {
    final GlobalModel globalSummaryModel;
    if (event is SummaryEventRequested) {
      yield SummaryStateLoading();
      try {
        globalSummaryModel = await globalSummaryRepository.getGlobalSummary();
        yield SummaryStateSuccess(globalSummaryModel: globalSummaryModel);
      } catch (err) {
        yield SummaryStateFailure(err);
      }
    }
    if (event is SummaryEventRefreshed) {
      try {
        final GlobalModel globalSummaryModel = await globalSummaryRepository.getGlobalSummary();
        yield SummaryStateSuccess(globalSummaryModel: globalSummaryModel);
      } catch (err) {
        yield SummaryStateFailure(err);
      }
    }
  }

  @override
  Future<void> close() async {
    //cancel streams
    super.close();
  }
}
