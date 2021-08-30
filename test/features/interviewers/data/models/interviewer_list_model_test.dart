import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:interview_feedback/core/data/models/interviewer_model.dart';
import 'package:interview_feedback/features/interviewers/data/models/interviewer_list_model.dart';
import 'package:interview_feedback/features/interviewers/domain/entities/interviewer_list.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final testInterviewerListModel = InterviewerListModel(interviewerList: [
    InterviewerModel(name: 'Lea Li'),
    InterviewerModel(name: 'Ole Moland'),
  ]);

  test('Should be a subclass of InterviewerList entity.', () async {
    // assert
    expect(testInterviewerListModel, isA<InterviewerList>());
  });

  group('fromJson', () {
    test('Should return valid model.', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('interviewer_list.json'));

      // act
      final result = InterviewerListModel.fromJson(jsonMap);

      // assert
      expect(result, testInterviewerListModel);
    });
  });
}
