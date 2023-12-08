import 'package:micro_routing/micro_routing.dart';

void main() {
  // Registering the application route
  RouteTable.register(handler: () => 'Main route is called!');

  // Getting route instance based on the URI and HttpMethod.
  final route = RouteTable.retrieve('/', HttpMethod.get);

  // Calling the route handler
  print(route.handler());
  //output: Main route is called!
}
