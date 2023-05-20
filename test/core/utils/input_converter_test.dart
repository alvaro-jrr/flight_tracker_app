import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flight_tracker_app/core/utils/input_converter.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedInt', () {
    test(
      "should return an integer when the string represents an unsigned integer",
      () async {
        // arrange
        const str = "123";

        // act
        final result = inputConverter.stringToUnsignedInteger(str);

        // assert
        expect(result, const Right(123));
      },
    );

    test(
      "should return a Failure when the string is not an integer",
      () async {
        // arrange
        const str = "abc";

        // act
        final result = inputConverter.stringToUnsignedInteger(str);

        // assert
        expect(result, Left(InvalidInputFailure()));
      },
    );

    test(
      "should return a Failure when the string is a negative integer",
      () async {
        // arrange
        const str = "-123";

        // act
        final result = inputConverter.stringToUnsignedInteger(str);

        // assert
        expect(result, Left(InvalidInputFailure()));
      },
    );
  });

  group('stringToCountryCode', () {
    test(
      'should be a two-letter code',
      () async {
        // arrange
        const str = 'ab';

        // act
        final result = inputConverter.stringToCountryCode(str);

        // assert
        expect(result, const Right(str));
      },
    );

    test(
      'should return a Failure when the string is empty',
      () async {
        // arrange
        const str = '';

        // act
        final result = inputConverter.stringToCountryCode(str);

        // assert
        expect(result, Left(InvalidInputFailure()));
      },
    );

    test(
      'should return a Failure when the string is not a two-letter code',
      () async {
        // arrange
        const str = 'abc';

        // act
        final result = inputConverter.stringToCountryCode(str);

        // assert
        expect(result, Left(InvalidInputFailure()));
      },
    );
  });
}
