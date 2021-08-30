import 'package:dartz/dartz.dart';
import 'package:interview_feedback/core/error/failures.dart';

abstract class UseCase<Type> {
  Future<Either<Failure, Type>> call();
}
