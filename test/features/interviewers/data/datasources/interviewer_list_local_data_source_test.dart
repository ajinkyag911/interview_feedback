import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:interview_feedback/core/data/models/interviewer_model.dart';
import 'package:interview_feedback/core/error/exceptions.dart';
import 'package:interview_feedback/features/interviewers/data/datasources/interviewer_list_local_data_source.dart';
import 'package:interview_feedback/features/interviewers/data/models/interviewer_list_model.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  InterviewerListLocalDataSourceImpl dataSourceImpl;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSourceImpl = InterviewerListLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group('getLastInterviewerList', () {
    final testInterviewerListModel = InterviewerListModel.fromJson(
        json.decode(fixture('interviewer_list_cached.json')));

    test(
        'Should return InterviewerList from SharedPreferences when there is one in the cache.',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('interviewer_list_cached.json'));

      // act
      final result = await dataSourceImpl.getLastInterviewerList();

      // assert
      verify(mockSharedPreferences.getString(CACHED_INTERVIEWER_LIST));
      expect(result, equals(testInterviewerListModel));
    });

    test('Should throw a CacheException when there is not a cached value.',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      // act
      final call = dataSourceImpl.getLastInterviewerList;

      // assert
      expect(() => call(), throwsA(isInstanceOf<CacheException>()));
    });
  });

  group('cacheNumberTrivia', () {
    final testInterviewerListModel = InterviewerListModel(interviewerList: [
      InterviewerModel(name: 'Lea Li'),
      InterviewerModel(name: 'Ole Moland'),
    ]);
    test('Should call SharedPreferences to cache the data,', () async {
      // act
      dataSourceImpl.cacheInterviewerList(testInterviewerListModel);

      // assert
      final expectedJsonString = json.encode(testInterviewerListModel.toJson());
      verify(mockSharedPreferences.setString(
          CACHED_INTERVIEWER_LIST, expectedJsonString));
    });
  });
}
