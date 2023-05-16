import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:flight_tracker_app/core/error/failures.dart';
import 'package:flight_tracker_app/core/utils/constants.dart';
import 'package:flight_tracker_app/core/utils/utils.dart';

class UnknownFailure extends Failure {
  @override
  List<Object> get props => [];
}

void main() {
  group('toTitleCase', () {
    test(
      'first character should be in uppercase',
      () async {
        // arrange
        const str = 'abc';

        // act
        final result = toTitleCase(str);

        // assert
        expect(result.characters.first, 'A');
      },
    );

    test(
      'every character after first character should be in lowercase',
      () async {
        // arrange
        const str = 'abc';

        // act
        final result = toTitleCase(str);

        // assert
        expect(result, 'Abc');
      },
    );

    test(
      'should return an empty string when the string is empty',
      () async {
        // arrange
        const str = '';

        // act
        final result = toTitleCase(str);

        // assert
        expect(result, '');
      },
    );

    test(
      'should return only the first character if string length is 1',
      () async {
        // arrange
        const str = 'a';

        // act
        final result = toTitleCase(str);

        // assert
        expect(result, 'A');
      },
    );

    test(
      'every word should have the first character in uppercase',
      () async {
        // arrange
        const str = 'test test';

        // act
        final result = toTitleCase(str);

        // assert
        expect(result, 'Test Test');
      },
    );

    test(
      'should split the word according to the separator',
      () async {
        // arrange
        const str = 'test-test';

        // act
        final result = toTitleCase(str, separator: '-');

        // assert
        expect(result, 'Test-Test');
      },
    );
  });

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
