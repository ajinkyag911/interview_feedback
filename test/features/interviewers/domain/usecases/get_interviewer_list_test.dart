import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interview_feedback/core/data/models/interviewer_model.dart';
import 'package:interview_feedback/features/interviewers/domain/entities/interviewer_list.dart';
import 'package:interview_feedback/features/interviewers/domain/repositories/interviewer_list_repository.dart';
import 'package:interview_feedback/features/interviewers/domain/usecases/get_interviewer_list.dart';
import 'package:mockito/mockito.dart';

class MockInterviewerListRepository extends Mock
    implements InterviewerListRepository {}

void main() {
  GetInterviewerList usecase;
  MockInterviewerListRepository mockInterviewerListRepository;

  setUp(() {
    mockInterviewerListRepository = MockInterviewerListRepository();
    usecase = GetInterviewerList(mockInterviewerListRepository);
  });

  final testInterviewerList = InterviewerList(interviewerList: [
    InterviewerModel(name: 'John'),
    InterviewerModel(name: 'Sara')
  ]);

  test('Should return list of interviewers.', () async {
    // arrange
    when(mockInterviewerListRepository.getInterviewerList())
        .thenAnswer((_) async => Right(testInterviewerList));

    // act
    final result = await usecase();

    // assert
    expect(result, Right(testInterviewerList));
    verify(mockInterviewerListRepository.getInterviewerList());
    verifyNoMoreInteractions(mockInterviewerListRepository);
  });
}
