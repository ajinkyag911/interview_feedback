part of 'interviewer_list_bloc.dart';

abstract class InterviewerListState extends Equatable {
  const InterviewerListState();
}

class InterviewerListInitial extends InterviewerListState {
  @override
  List<Object> get props => [];
}

class Empty extends InterviewerListState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Loading extends InterviewerListState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Loaded extends InterviewerListState {
  final InterviewerList interviewerList;

  Loaded({@required this.interviewerList});

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadedSearch extends InterviewerListState {
  final InterviewerList interviewerList;

  LoadedSearch({@required this.interviewerList});

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Error extends InterviewerListState {
  final String errorMessage;

  Error({@required this.errorMessage});

  @override
  // TODO: implement props
  List<Object> get props => [];
}
