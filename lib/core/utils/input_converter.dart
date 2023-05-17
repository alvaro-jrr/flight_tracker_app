import 'package:dartz/dartz.dart';

import 'package:flight_tracker_app/core/error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    final integer = int.tryParse(str);

    // In case is not an string representing an integer or negative.
    if (integer == null || integer < 0) {
      return Left(InvalidInputFailure());
    }

    return Right(integer);
  }

  Either<Failure, String> stringToCountryCode(String str) {
    str = str.trim();

    if (str.isEmpty || str.length > 2) {
      return Left(InvalidInputFailure());
    }

    return Right(str);
  }
}

class InvalidInputFailure extends Failure {
  @override
  List<Object> get props => [];
}
