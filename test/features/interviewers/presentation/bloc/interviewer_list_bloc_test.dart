import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interview_feedback/core/data/models/interviewer_model.dart';
import 'package:interview_feedback/core/error/failures.dart';
import 'package:interview_feedback/features/interviewers/domain/entities/interviewer_list.dart';
import 'package:interview_feedback/features/interviewers/domain/usecases/get_interviewer_list.dart';
import 'package:interview_feedback/features/interviewers/presentation/bloc/interviewer_list_bloc.dart';
import 'package:mockito/mockito.dart';

class MockGetInterviewerList extends Mock implements GetInterviewerList {}

void main() {
  InterviewerListBloc bloc;
  MockGetInterviewerList mockGetInterviewerList;

  setUp(() {
    mockGetInterviewerList = MockGetInterviewerList();
    bloc = InterviewerListBloc(getInterviewerList: mockGetInterviewerList);
  });

  group('Get interviewer list', () {
    final testInterviewerList = InterviewerList(interviewerList: [
      InterviewerModel(name: 'Lea Li'),
      InterviewerModel(name: 'Ole Moland'),
    ]);

    test(
      'Should get data from use case',
      () async {
        // arrange
        when(mockGetInterviewerList())
            .thenAnswer((_) async => Right(testInterviewerList));
        // act
        bloc.add(GetTheInterViewerList());
        await untilCalled(mockGetInterviewerList());
        // assert
        verify(mockGetInterviewerList());
      },
    );

    test(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // arrange
        when(mockGetInterviewerList())
            .thenAnswer((_) async => Right(testInterviewerList));
        // assert later
        final expected = [
          // Empty(),
          Loading(),
          Loaded(interviewerList: testInterviewerList),
        ];
        expectLater(bloc.stream.asBroadcastStream(), emitsInOrder(expected));
        // act
        bloc.add(GetTheInterViewerList());
      },
    );

    test(
      'Should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        when(mockGetInterviewerList())
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          // Empty(),
          Loading(),
          Error(errorMessage: 'SERVER_FAILURE'),
        ];
        expectLater(bloc.stream.asBroadcastStream(), emitsInOrder(expected));
        // act
        bloc.add(GetTheInterViewerList());
      },
    );

    test(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
      () async {
        // arrange
        when(mockGetInterviewerList())
            .thenAnswer((_) async => Left(CacheFailure()));
        // assert later
        final expected = [
          // Empty(),
          Loading(),
          Error(errorMessage: 'CACHE_FAILURE'),
        ];
        expectLater(bloc.stream.asBroadcastStream(), emitsInOrder(expected));
        // act
        bloc.add(GetTheInterViewerList());
      },
    );
  });
}
