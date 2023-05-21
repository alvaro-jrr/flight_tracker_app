# Flight Tracker App

Track any flight worldwide and the airports around the world.

## Getting Started

-   Get an API key at [API Ninjas](https://api-ninjas.com/).
-   Get an API key at [Aviation Stack](https://aviationstack.com/).
-   Get an API key at [Google Maps Platform](https://cloud.google.com/maps-platform/).

### General

1. Run the `flutter pub get` to get the packages needed.

2. Create an `.env` file in the project root folder, with the following content:

```
AVIATION_STACK_KEY="YOUR AVIATION STACK API KEY"
API_NINJAS_KEY="YOUR API NINJAS API KEY"
```

3. Run the following command:

```sh
flutter pub run build_runner build --delete-conflicting-outputs
```

### Google Maps

#### Android

In `project/android` folder create or modify the `local.properties` file and add the following:

```
GOOGLE_MAPS_API_KEY=YOUR_GOOGLE_MAPS_API_KEY
```

#### iOS

In `project/ios/Flutter` folder create or modify the `Debug.xcconfig` file and add the following:

```
#include "Generated.xcconfig"

GOOGLE_MAPS_API_KEY=YOUR_GOOGLE_MAPS_API_KEY
```

## Built With 🛠️

-   [API Ninkas](https://api-ninjas.com/) - Airports API.
-   [AviationStack](https://aviationstack.com/) - Flights API.
-   [dartz](https://pub.dev/packages/dartz) - Functional programming in Dart.
-   [http](https://pub.dev/packages/http) - Handle HTTP Requests.
-   [get_it](https://pub.dev/packages/get_it) - Service Locator.
-   [bloc](https://pub.dev/packages/bloc) - State Management.
-   [flutter_bloc](https://pub.dev/packages/flutter_bloc) - Integrate blocs in Flutter.
-   [internet_connection_checker](https://pub.dev/packages/internet_connection_checker) - Checks the internet connection.
-   [envied](https://pub.dev/packages/envied) - Handle enviroment variables in Dart/Flutter.
-   [equatable](https://pub.dev/packages/equatable) - Equality comparisons.
-   [intl](https://pub.dev/packages/intl) - Format date.
-   [circle_flags](https://pub.dev/packages/circle_flags) - Display flag.
-   [google_maps_flutter](https://pub.dev/packages/google_maps_flutter) - Provide Google Maps.

## Screenshots 📷

![Flights page](/screenshots/flights_page.png)

![Airports page](/screenshots/airports_page.png)

![Airport location page](/screenshots/airport_location_page.jpg)

## Author ✒️

-   [Alvaro Resplandor](https://github.com/alvaro-jrr/)
