import 'dart:io';

import 'package:micro_routing/micro_routing.dart';
import 'package:test/test.dart';

void main() {
  group('Testing registering routes: ', () {
    test('providing an absolute URI', () {
      expect(
          () => RouteTable.register(
              path: 'http://example.com/something', handler: () => 'Works!'),
          throwsException);
    });

    test('providing an absolute URI with IP', () {
      expect(
          () => RouteTable.register(
              path: 'http://127.0.0.1/something', handler: () => 'Works!'),
          throwsException);
    });

    test('providing `//` for the path', () {
      expect(() => RouteTable.register(path: '//', handler: () => 'Works!'),
          throwsException);
    });

    test('providing duplicate paths', () {
      expect(() {
        RouteTable.register(path: '/duplicate/path', handler: () => 'Works!');
        RouteTable.register(path: '/duplicate/path', handler: () => 'Works!');
      }, throwsException);
    });

    test('providing duplicate path parameters', () {
      expect(
          () => RouteTable.register(
              path: '/user/:id/profiles/:id', handler: () => 'Works!'),
          throwsException);
    });

    test('providing numbers as path params', () {
      expect(() => RouteTable.register(path: '/:1029', handler: () => 'Works!'),
          throwsException);
    });

    test('providing symbols as path params', () {
      expect(
          () =>
              RouteTable.register(path: '/:\$&&^^!!', handler: () => 'Works!'),
          throwsException);
    });

    test('providing alphanumeric path params', () {
      expect(
          () =>
              RouteTable.register(path: '/:userId01', handler: () => 'Works!'),
          throwsException);
    });

    test('retrieve non-existent route', () {
      expect(() => RouteTable.retrieve('/non-existent', HttpMethod.post),
          throwsException);
    });
  });

  group('test GET `/` route: ', () {
    RouteTable.register(handler: () => 'GET MAIN');
    final route = RouteTable.retrieve('/', HttpMethod.get);

    test('testing the path', () => expect(route.path, '/'));
    test('testing the method', () => expect(route.method, HttpMethod.get));
    test('testing the handler', () => expect(route.handler(), 'GET MAIN'));
    test('testing consumes', () => expect(route.consumes, ContentType.json));
    test('testing produces', () => expect(route.produces, ContentType.json));
  });

  group('test POST `/` route: ', () {
    RouteTable.register(method: HttpMethod.post, handler: () => 'POST MAIN');
    final route = RouteTable.retrieve('/', HttpMethod.post);

    test('testing the path', () => expect(route.path, '/'));
    test('testing the method', () => expect(route.method, HttpMethod.post));
    test('testing the handler', () => expect(route.handler(), 'POST MAIN'));
    test('testing consumes', () => expect(route.consumes, ContentType.json));
    test('testing produces', () => expect(route.produces, ContentType.json));
  });
}
