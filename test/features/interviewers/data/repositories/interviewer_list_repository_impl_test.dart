import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interview_feedback/core/data/models/interviewer_model.dart';
import 'package:interview_feedback/core/error/exceptions.dart';
import 'package:interview_feedback/core/error/failures.dart';
import 'package:interview_feedback/core/network/network_info.dart';
import 'package:interview_feedback/features/interviewers/data/datasources/interviewer_list_local_data_source.dart';
import 'package:interview_feedback/features/interviewers/data/datasources/interviewer_list_remote_data_source.dart';
import 'package:interview_feedback/features/interviewers/data/models/interviewer_list_model.dart';
import 'package:interview_feedback/features/interviewers/data/repositories/interviewer_list_repository_impl.dart';
import 'package:interview_feedback/features/interviewers/domain/entities/interviewer_list.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock
    implements InterviewerListRemoteDataSource {}

class MockLocalDataSource extends Mock
    implements InterviewerListLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  InterviewerListRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = InterviewerListRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getInterviewerList', () {
    final testInterviewerListModel = InterviewerListModel(interviewerList: [
      InterviewerModel(name: 'TestName 1'),
      InterviewerModel(name: 'TestName 2'),
    ]);
    final InterviewerList testInterviewerList = testInterviewerListModel;

    test('Should check if device is online.', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      // act
      repository.getInterviewerList();

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('Device is online.', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'Should return remote data when call to remote data source is successful.',
          () async {
        // arrange
        when(mockRemoteDataSource.getInterviewerList())
            .thenAnswer((_) async => testInterviewerListModel);

        // act
        final result = await repository.getInterviewerList();

        // assert
        verify(mockRemoteDataSource.getInterviewerList());
        expect(result, Right(testInterviewerList));
      });

      test(
          'Should cache the data locally when the call to remote data is successful.',
          () async {
        // arrange
        when(mockRemoteDataSource.getInterviewerList())
            .thenAnswer((_) async => testInterviewerListModel);

        // act
        await repository.getInterviewerList();

        // assert
        verify(mockRemoteDataSource.getInterviewerList());
        verify(
            mockLocalDataSource.cacheInterviewerList(testInterviewerListModel));
      });

      test(
          'Should return server failure  when call to remote data source is un successful.',
          () async {
        // arrange
        when(mockRemoteDataSource.getInterviewerList())
            .thenThrow(ServerException());

        // act
        final result = await repository.getInterviewerList();

        // assert
        verify(mockRemoteDataSource.getInterviewerList());
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, Left(ServerFailure()));
      });
    });

    group('Device is offline.', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
          'Should return last locally cached data when the cached data is present.',
          () async {
        // arrange
        when(mockLocalDataSource.getLastInterviewerList())
            .thenAnswer((_) async => testInterviewerListModel);

        // act
        final result = await repository.getInterviewerList();

        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastInterviewerList());
        expect(result, Right(testInterviewerList));
      });

      test('Should return CacheFailure when there is no cached data present.',
          () async {
        // arrange
        when(mockLocalDataSource.getLastInterviewerList())
            .thenThrow(CacheException());

        // act
        final result = await repository.getInterviewerList();

        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastInterviewerList());
        expect(result, Left(CacheFailure()));
      });
    });
  });
}
