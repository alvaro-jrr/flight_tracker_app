import 'package:flight_tracker_app/core/error/failures.dart';
import 'package:flight_tracker_app/core/utils/constants.dart';

/// Returns a message according to the [failure] type.
String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return serverFailureMessage;

    case UsageLimitFailure:
      return usageFailureMessage;

    case NoInternetConnectionFailure:
      return noInternetConnectionFailureMessage;

    default:
      return unexpectedFailureMessage;
  }
}
