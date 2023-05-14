import 'package:flutter_test/flutter_test.dart';

import 'package:flight_tracker_app/core/error/failures.dart';
import 'package:flight_tracker_app/core/utils/constants.dart';
import 'package:flight_tracker_app/core/utils/utils.dart';

class UnknownFailure extends Failure {
  @override
  List<Object> get props => [];
}

void main() {
  group('mapFailureToMessage', () {
    test(
      'should return the proper message when is a ServerFailure',
      () async {
        // act
        final result = mapFailureToMessage(ServerFailure());

        // assert
        expect(result, serverFailureMessage);
      },
    );
    test(
      'should return the proper message when is a UsageLimitFailure',
      () async {
        // act
        final result = mapFailureToMessage(UsageLimitFailure());

        // assert
        expect(result, usageFailureMessage);
      },
    );

    test(
      'should return the proper message when is a NoInternetConnectionFailure',
      () async {
        // act
        final result = mapFailureToMessage(NoInternetConnectionFailure());

        // assert
        expect(result, noInternetConnectionFailureMessage);
      },
    );

    test(
      'should return the proper message when is other Failure',
      () async {
        // act
        final result = mapFailureToMessage(UnknownFailure());

        // assert
        expect(result, unexpectedFailureMessage);
      },
    );
  });
}
