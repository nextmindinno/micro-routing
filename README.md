<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

## Features

The routing library for MicroMeter. The library provides a way to define various routes and handlers.
When the routes are retrieved, the reference of the handler is also received which can be called later.


## Usage

TODO: Include short and useful examples for package users. 

```dart
// Registering the application route
  RouteTable.register(handler: () => 'Main route is called!');

  // Getting route instance based on the URI and HttpMethod.
  final route = RouteTable.retrieve('/', HttpMethod.get);

  // Calling the route handler
  print(route.handler());
  //output: Main route is called!
```
