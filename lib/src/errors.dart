/// The library contains all the exceptions being thrown by routing module.
///
/// The exceptions includes:
///   - PathNotFoundException
///   - NotRelativePathException
///   - EmptyPathProvidedException
///   - DuplicatePathDefinedException
///   - InvalidPathParamFormatException
///   - PathContainsQueryParamsException
library;

/// An exception class is thrown when the requested path is not found in
/// the route table.
final class PathNotFoundException implements Exception {
  final String path;
  final String method;

  const PathNotFoundException(this.path, this.method);

  @override
  String toString() => 'The path not found: ($method: $path)';
}

/// An exception class is thrown when the provided path is
/// not a relative path.
///
/// A relative path starts with `/...`, which has protocol,
/// host, and ports are missing. The routes can only be
/// defined using the relative path.
final class NotRelativePathException implements Exception {
  final String path;

  const NotRelativePathException(this.path);

  @override
  String toString() => 'An absolute path provided: ($path)';
}

/// An exception class is thrown when the provided path is empty.
///
/// This is the case when user provides paths like `//` or `///`.
final class EmptyPathProvidedException implements Exception {
  @override
  String toString() => 'An empty path is provided';
}

/// An exception class is thrown when user defines duplicate paths.
///
/// A duplicate path is that which has a matching method and path URI
/// already been defined. If the path URI is the same, but different
/// HTTP methods are provided then they are not the duplicate paths.
final class DuplicatePathDefinedException implements Exception {
  final String path;
  final String method;

  const DuplicatePathDefinedException(this.path, this.method);

  @override
  String toString() => 'The path is already defined: ($method: $path)';
}

/// An exception class is thrown when query parameters are provided.
///
/// This is the case when user while defining the routes, provides
/// query parameters along with the path. The route path must not
/// contained any query parameters.
final class PathContainsQueryParamsException implements Exception {
  final Map<String, String> params;

  const PathContainsQueryParamsException(this.params);

  @override
  String toString() => 'The path contains query parameter(s): ($params)';
}

/// An exception class is thrown when the path parameter contains invalid
/// characters.
final class InvalidPathParamFormatException implements Exception {
  final String param;

  const InvalidPathParamFormatException(this.param);

  @override
  String toString() => 'The path parameter(s) has invalid format: ($param)';
}

/// An exception class is thrown when duplicate path parameters are provided.
///
/// A path must contained non-duplicated path parameters. If the path params
/// are duplicated, then it becomes confusing that which parameter is what,
/// when processing the parameter injection.
final class DuplicatePathParamsDefinedException implements Exception {
  final String param;

  const DuplicatePathParamsDefinedException(this.param);

  @override
  String toString() => 'The duplicate path parameter(s) defined: ($param)';
}
