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

When you define only a `handler`, then handler is accessed by providing default method `GET` and default path `/`.
```dart
  // Defining a handler
  RouteTable.register(handler: () => 'Main route is called!');
  
  // Getting route instance based on the URI and HttpMethod.
  final route = RouteTable.retrieve('/', HttpMethod.get);

  // Calling the route handler
  print(route.handler());
  //output: Main route is called!
```

When you define a route with `handler` and `method`, then handler is accessed by providing `method` and default path `/`.
```dart
  // Registering the application route
  RouteTable.register(method: HttpMethod.post, handler: () => 'Main route is called!');

  // Getting route instance based on the URI and HttpMethod.
  final route = RouteTable.retrieve('/', HttpMethod.post);

  // Calling the route handler
  print(route.handler());
  //output: Main route is called!
```

When you define a route with `path`, `method` and `handler`, the route handler then retrieved as:
```dart
  // Registering the application route
  RouteTable.register(
      path: '/users',
      method: HttpMethod.post,
      handler: () => 'Users route is called!');

  // Getting route instance based on the URI and HttpMethod.
  final route = RouteTable.retrieve('/users', HttpMethod.post);

  // Calling the route handler
  print(route.handler());
  //output: Users route is called!
```

Providing optional `consumes` flag to the route:
```dart
  // Registering the application route
  RouteTable.register(
      path: '/users',
      method: HttpMethod.post,
      handler: () => 'Users route is called!',
      consumes: ContentType.json);

  // Getting route instance based on the URI and HttpMethod.
  final route = RouteTable.retrieve('/users', HttpMethod.post);

  // Calling the route handler
  print(route.handler());
  //output: Users route is called!
```

Providing optional `produces` flag to the route:
```dart
  // Registering the application route
  RouteTable.register(
      path: '/users',
      method: HttpMethod.post,
      handler: () => 'Users route is called!',
      consumes: ContentType.json,
      produces: ContentType.json);

  // Getting route instance based on the URI and HttpMethod.
  final route = RouteTable.retrieve('/users', HttpMethod.post);

  // Calling the route handler
  print(route.handler());
  //output: Users route is called!
```