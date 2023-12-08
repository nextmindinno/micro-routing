import 'dart:io';

import 'package:micro_routing/micro_routing.dart';

void main() {
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
}
