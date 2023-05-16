import 'package:dartz/dartz.dart';

import 'package:flight_tracker_app/core/error/failures.dart';

abstract class UseCase<ReturnType, ParamsType> {
  Future<Either<Failure, ReturnType>> call(ParamsType params);
}
