import 'package:flight_tracker_app/core/error/failures.dart';
import 'package:flight_tracker_app/core/utils/constants.dart';

/// Returns the [str] with each word with the first character
/// in upper case.
String toTitleCase(String str, {String separator = ' '}) {
  if (str.isEmpty) return '';

  final words = str.split(separator);

  return words.map((word) {
    // Uppercase first character.
    return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
  }).join(separator);
}

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
