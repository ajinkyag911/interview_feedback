import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:interview_feedback/core/data/models/interviewer_model.dart';

class InterviewerList extends Equatable {
  final List<InterviewerModel> interviewerList;

  InterviewerList({
    @required this.interviewerList,
  });

  @override
  // TODO: implement props
  List<Object> get props => [interviewerList];
}
