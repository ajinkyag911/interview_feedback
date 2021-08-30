import 'package:dartz/dartz.dart';
import 'package:interview_feedback/core/error/failures.dart';
import 'package:interview_feedback/features/interviewers/domain/entities/interviewer_list.dart';

abstract class InterviewerListRepository {
  Future<Either<Failure, InterviewerList>> getInterviewerList();
}
