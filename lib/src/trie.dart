/// The file contains the code that deals with Trie Data Structure.
///
/// The Trie data structure is a tree structure for Trie nodes. It is
/// basically a tree, which allows the contexts look up and all.
/// The current trie data structure is used to store application wide
/// routing information and path variables.
///
/// The routing path can be added and retrieved using the routing table
/// which behind the scene employs this data structure code.
library;

import 'dart:io';

import 'package:micro_routing/micro_routing.dart';
import 'package:path/path.dart';

/// The class holds the routing path segment.
///
/// It also contains reference to the parent and child nodes.
final class TrieNode<K> {
  /// Holds path segment
  K? key;

  /// Holds the reference to the parent path segment
  TrieNode? patent;

  /// Holds the reference to what HTTP methods are allowed
  final Map<HttpMethod, Function> handlers = {};

  /// Holds the reference to the route metadata
  final Map<HttpMethod, Map<String, ContentType>> headers = {};

  /// Holds the reference to the child path segments
  final Map<K, TrieNode<K>?> children = {};

  /// Specifies whether the node is terminating or not
  bool isTerminating = false;

  TrieNode({this.key, this.patent});
}

/// The class represents a Trie Tree data structure.
final class Trie {
  final _root = TrieNode<String>();
  final _context = Context(style: Style.url);

  /// Appends the route to the Trie.
  ///
  /// The method takes [route] as an input and constructs the [TrieNode].
  /// The method also takes in consideration of the duplicate query params
  /// and if that happens, the [DuplicatePathDefinedException] will be raised.
  void append(final Route route) {
    final uri = _context.toUri(route.path);

    var node = _root;
    for (final segment in uri.pathSegments) {
      node.children[segment] ??= TrieNode(key: segment, patent: node);
      node = node.children[segment]!;
    }

    // Do not add the same URI with the same HTTP HTTP method again
    if (node.handlers.keys.contains(route.method)) {
      throw DuplicatePathDefinedException(route.path, route.method.name);
    }

    node.handlers[route.method] = route.handler;
    node.headers[route.method] = {
      'consumes': route.consumes,
      'produces': route.produces
    };

    node.isTerminating = true;
  }

  /// Returns the registered path.
  ///
  /// The method accepts [HttpMethod] and [path] as an input. Based on the
  /// provided input, it looks for the registered path. If the path is not
  /// registered then [PathNotFoundException] is raised.
  Route get(final String path, final HttpMethod method) {
    final uri = _context.toUri(path);
    final params = <String, String>{};

    var node = _root;
    for (final segment in uri.pathSegments) {
      final childNode = node.children[segment];

      if (childNode == null) {
        var param = node.children.keys.where((s) => s.startsWith(":"));
        if (param.isEmpty) {
          throw PathNotFoundException(path, method.toString());
        }

        var key = param.first;
        params[key.substring(1)] = segment;
        node = node.children[key]!;
        continue;
      }

      node = childNode;
    }

    if (!node.handlers.keys.contains(method)) {
      throw PathNotFoundException(path, method.toString());
    }

    return Route(
        path,
        method,
        node.handlers[method]!,
        node.headers[method]!['consumes']!,
        node.headers[method]!['produces']!,
        params);
  }
}
