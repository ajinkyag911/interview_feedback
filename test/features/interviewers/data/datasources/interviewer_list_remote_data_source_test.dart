import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:interview_feedback/core/error/exceptions.dart';
import 'package:interview_feedback/features/interviewers/data/datasources/interviewer_list_remote_data_source.dart';
import 'package:interview_feedback/features/interviewers/data/models/interviewer_list_model.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  InterviewerListRemoteDataSourceImpl dataSourceImpl;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSourceImpl =
        InterviewerListRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getInterviewerList', () {
    final testInterviewerListModel = InterviewerListModel.fromJson(
        json.decode(fixture('interviewer_list.json')));

    test('Should perform a get request on a URL and with headers.', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('any'))).thenAnswer(
          (_) async => http.Response(fixture('interviewer_list.json'), 200));

      // act
      dataSourceImpl.getInterviewerList();

      // assert
      /*
         verify(mockHttpClient.get(
           Uri.parse('https://randomuser.me/api/?results=20'),
           // headers: {'results' : '20'}
           headers: {
             'Content-Type': 'application/json',
           },
         ));
          */
      verify(mockHttpClient
          .get(Uri.parse("https://randomuser.me/api/?results=20")));
    });

    test('Should return InterviewerList when the response code is 200.',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('any'))).thenAnswer(
          (_) async => http.Response(fixture('interviewer_list.json'), 200));

      // act
      final result = await dataSourceImpl.getInterviewerList();

      // assert
      expect(result, equals(testInterviewerListModel));
    });

    test(
        'Should throw a ServerException when the response code is 40 or other.',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('any')))
          .thenAnswer((_) async => http.Response('Something went wrong.', 404));

      // act
      final call = dataSourceImpl.getInterviewerList;

      // assert
      expect(() => call(), throwsA(isInstanceOf<ServerException>()));
    });
  });
}
