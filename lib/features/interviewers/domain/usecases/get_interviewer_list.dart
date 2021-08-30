import 'package:dartz/dartz.dart';
import 'package:interview_feedback/core/error/failures.dart';
import 'package:interview_feedback/core/usecases/usecase.dart';
import 'package:interview_feedback/features/interviewers/domain/entities/interviewer_list.dart';
import 'package:interview_feedback/features/interviewers/domain/repositories/interviewer_list_repository.dart';

class GetInterviewerList implements UseCase<InterviewerList> {
  final InterviewerListRepository repository;

  GetInterviewerList(this.repository);

  @override
  Future<Either<Failure, InterviewerList>> call() async {
    return await repository.getInterviewerList();
  }
}
