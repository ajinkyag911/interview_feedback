import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:interview_feedback/core/error/exceptions.dart';
import 'package:interview_feedback/core/error/failures.dart';
import 'package:interview_feedback/core/network/network_info.dart';
import 'package:interview_feedback/features/interviewers/data/datasources/interviewer_list_local_data_source.dart';
import 'package:interview_feedback/features/interviewers/data/datasources/interviewer_list_remote_data_source.dart';
import 'package:interview_feedback/features/interviewers/domain/entities/interviewer_list.dart';
import 'package:interview_feedback/features/interviewers/domain/repositories/interviewer_list_repository.dart';

class InterviewerListRepositoryImpl implements InterviewerListRepository {
  final InterviewerListRemoteDataSource remoteDataSource;
  final InterviewerListLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  InterviewerListRepositoryImpl(
      {@required this.remoteDataSource,
      @required this.localDataSource,
      @required this.networkInfo});

  @override
  Future<Either<Failure, InterviewerList>> getInterviewerList() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteInterviewerList =
            await remoteDataSource.getInterviewerList();
        localDataSource.cacheInterviewerList(remoteInterviewerList);
        return Right(remoteInterviewerList);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localInterviewerList =
            await localDataSource.getLastInterviewerList();
        return Right(localInterviewerList);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
