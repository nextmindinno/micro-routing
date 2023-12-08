import 'package:micro_routing/src/enums.dart';
import 'package:test/test.dart';

void main() {
  group('A group of HttpMethod tests: ', () {

    test('test - provide blank as HTTP method name', () {
      expect(() => HttpMethod.getByMethod(''), throwsArgumentError);
    });

    test('test - provide integer as HTTP method name', () {
      expect(() => HttpMethod.getByMethod('1'), throwsArgumentError);
    });

    test('test - provide double as HTTP method name', () {
      expect(() => HttpMethod.getByMethod('1.1'), throwsArgumentError);
    });

    test('test - provide `GET` as HTTP method name', () {
      expect(HttpMethod.getByMethod('GET'), HttpMethod.get);
    });

    test('test - provide `Get` as HTTP method name', () {
      expect(HttpMethod.getByMethod('GET'), HttpMethod.get);
    });

    test('test - provide `GeT` as HTTP method name', () {
      expect(HttpMethod.getByMethod('GeT'), HttpMethod.get);
    });

    test('test - provide `gET` as HTTP method name', () {
      expect(HttpMethod.getByMethod('gET'), HttpMethod.get);
    });

    test('test - provide `gET` as HTTP method name', () {
      expect(HttpMethod.getByMethod('gET'), HttpMethod.get);
    });

    test('test - provide `geT` as HTTP method name', () {
      expect(HttpMethod.getByMethod('geT'), HttpMethod.get);
    });

    test('test - provide `POST` as HTTP method name', () {
      expect(HttpMethod.getByMethod('POST'), HttpMethod.post);
    });

    test('test - provide `PUT` as HTTP method name', () {
      expect(HttpMethod.getByMethod('PUT'), HttpMethod.put);
    });

    test('test - provide `PATCH` as HTTP method name', () {
      expect(HttpMethod.getByMethod('PATCH'), HttpMethod.patch);
    });

    test('test - provide `DELETE` as HTTP method name', () {
      expect(HttpMethod.getByMethod('DELETE'), HttpMethod.delete);
    });
  });
}