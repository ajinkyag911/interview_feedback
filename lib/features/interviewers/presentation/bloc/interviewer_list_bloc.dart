import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:interview_feedback/core/error/failures.dart';
import 'package:interview_feedback/features/interviewers/domain/entities/interviewer_list.dart';
import 'package:interview_feedback/features/interviewers/domain/usecases/get_interviewer_list.dart';

part 'interviewer_list_event.dart';

part 'interviewer_list_state.dart';

class InterviewerListBloc
    extends Bloc<InterviewerListEvent, InterviewerListState> {
  final GetInterviewerList getInterviewerList;

  InterviewerListBloc({@required this.getInterviewerList})
      : super(InterviewerListInitial());

  @override
  Stream<InterviewerListState> mapEventToState(
    InterviewerListEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is GetTheInterViewerList) {
      yield Loading();
      final failureOrList = await getInterviewerList();
      yield* _eitherLoadedOrErrorState(failureOrList);
    }
  }

  Stream<InterviewerListState> _eitherLoadedOrErrorState(
    Either<Failure, InterviewerList> failureOrList,
  ) async* {
    yield failureOrList.fold(
      (failure) => Error(errorMessage: _mapFailureToMessage(failure)),
      (list) => Loaded(interviewerList: list),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'SERVER_FAILURE';
      case CacheFailure:
        return 'CACHE_FAILURE';
      default:
        return 'Unexpected error';
    }
  }
}
