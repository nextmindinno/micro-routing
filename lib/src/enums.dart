/// The enum defines the HTTP Methods supported by the framework.
///
/// Currently supported HTTP Methods are:
///   - GET
///   - POST
///   - PATCH
///   - PUT
///   - DELETE
enum HttpMethod {
  get('GET'),
  post('POST'),
  put('PUT'),
  patch('PATCH'),
  delete('DELETE');

  /// Holds the method value i.e. 'GET', 'POST'...
  final String method;

  /// Constructor
  const HttpMethod(this.method);

  /// Method returns the [HttpMethod] enum based on the provided [method].
  ///
  /// If the [method] is not defined in the enum, [ArgumentError] is thrown.
  /// Example:
  ///   HttpMethod method = HttpMethod.getByMethod('GET');
  static HttpMethod getByMethod(final String method) {
    switch (method.toUpperCase()) {
      case 'GET':
        return HttpMethod.get;
      case 'POST':
        return HttpMethod.post;
      case 'PUT':
        return HttpMethod.put;
      case 'PATCH':
        return HttpMethod.patch;
      case 'DELETE':
        return HttpMethod.delete;
      default:
        throw ArgumentError('the method name is not valid');
    }
  }

  /// Returns the string value of the enum.
  @override
  String toString() => method;
}
