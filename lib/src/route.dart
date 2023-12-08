import 'dart:io';

import 'package:path/path.dart';

import 'enums.dart';
import 'errors.dart';
import 'trie.dart';

/// A route class is used when registering and acquiring routes from the
/// routing table.
///
/// The object of this class contains information like,
///  - URI
///  - Method
///  - Method to be called
///  - Request and Response type
///
/// A user does not need to create any direct object of it, neither need to
/// extend or implement it. The user can simply call [RouteTable] register
/// method to register a route for the application.
final class Route {
  /// Holds the URI path
  final String path;

  /// Holds the URI method
  final HttpMethod method;

  /// Holds the reference to the method handler
  final Function handler;

  /// Holds the content type consumed by the URI
  ContentType consumes;

  /// Holds the content type produced by the URI
  ContentType produces;

  /// Holds the reference of the path params
  Map<String, String>? pathParams = {};

  /// The route constructor
  Route(this.path, this.method, this.handler, this.consumes, this.produces,
      [this.pathParams]);
}

/// A class that provides utility methods to register and getting the route.
///
/// The class cannot be instantiated, nor extended and implemented. It only
/// contains static methods that are be called anywhere from the application
/// to register and retrieving the route.
///
/// This is done to make sure, there is only one [RouteTable] throughout the
/// application lifecycle.
final class RouteTable {
  /// Holds Trie reference
  static final _tri = Trie();

  /// Holds path context, uses URL style paths.
  static final _context = Context(style: Style.url);

  /// Holds the regex expression for path parameters
  static final _paramExpression = RegExp(r'^[a-zA-Z]+$');

  /// blocks instantiation
  RouteTable._internal();

  /// Adds a route.
  ///
  /// The method calls the validation method. If the path is validated,
  /// it calls the Trie to store the routing information.
  static void register(
      {String? path,
      HttpMethod? method,
      ContentType? consumes,
      ContentType? produces,
      required Function handler}) {
    method ??= HttpMethod.get;
    consumes ??= ContentType.json;
    produces ??= ContentType.json;

    _validate(path ??= '/');
    _tri.append(Route(path, method, handler, consumes, produces));
  }

  /// Returns the registered route.
  ///
  /// As a part of searching for the route, a string [path] and [method]
  /// must be provided. if the path is not found, then an appropriate
  /// exception will thrown.
  static Route retrieve(final String path, final HttpMethod method) {
    return _tri.get(path, method);
  }

  /// Validates the route path.
  ///
  /// The method performs validation such as:
  ///   - Routing path correction
  ///   - No Protocol, host and port provided
  ///   - Duplications of path params
  ///
  /// An appropriate exception is raised when the path is invalid.
  /// The following exceptions are raised as a part of validations
  ///   - [NotRelativePathException] when the path is not relative.
  ///   - [EmptyPathProvidedException] when the path is empty.
  ///   - [PathContainsQueryParamsException] when the path contains
  ///     query params.
  ///   - [DuplicatePathParamsDefinedException] when the path contains
  ///     duplicate params.
  static void _validate(final String path) {
    if (_context.isAbsolute(path) && !_context.isRootRelative(path)) {
      throw NotRelativePathException(path);
    }

    final uri = _context.toUri(path);
    if (uri.path.isEmpty) {
      throw EmptyPathProvidedException();
    }

    if (uri.hasQuery) {
      throw PathContainsQueryParamsException(uri.queryParameters);
    }

    final pathParams = <String>{};
    for (var segment in uri.pathSegments) {
      if (segment.startsWith(":")) {
        final param = segment.substring(1);
        if (pathParams.contains(param)) {
          throw DuplicatePathParamsDefinedException(param);
        }
        pathParams.add(_validatePathParam(param));
      }
    }
  }

  /// Validates the path parameters.
  ///
  /// The path parameters must be valid string. Only the characters
  /// between `a-z` and `A-Z` is allowed. If the path param is not
  /// valid then [InvalidPathParamFormatException] will be thrown.
  static String _validatePathParam(final String param) {
    return !_paramExpression.hasMatch(param)
        ? throw InvalidPathParamFormatException(param)
        : param;
  }
}
