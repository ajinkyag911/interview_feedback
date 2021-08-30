import 'package:flutter/foundation.dart';
import 'package:interview_feedback/core/data/models/interviewer_model.dart';
import 'package:interview_feedback/features/interviewers/domain/entities/interviewer_list.dart';

class InterviewerListModel extends InterviewerList {
  InterviewerListModel({
    @required List<InterviewerModel> interviewerList,
  }) : super(interviewerList: interviewerList);

  factory InterviewerListModel.fromJson(Map<String, dynamic> json) {
    var interviewerListFromJson = json['results'];

    List<InterviewerModel> interviewerList =
        new List<InterviewerModel>.from(interviewerListFromJson.map((element) {
      return InterviewerModel.fromJson(element);
    }).toList());

    InterviewerListModel result =
        InterviewerListModel(interviewerList: interviewerList);

    return result;
  }

  Map<String, dynamic> toJson() {
    return {'interviewerList': interviewerList.map((e) => e.toJson()).toList()};
  }
}
