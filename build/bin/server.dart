// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, implicit_dynamic_list_literal

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';


import '../routes/index.dart' as index;
import '../routes/user/index.dart' as user_index;
import '../routes/user/[id].dart' as user_$id;
import '../routes/lists/index.dart' as lists_index;
import '../routes/items/index.dart' as items_index;

import '../routes/_middleware.dart' as middleware;

void main() async {
  final address = InternetAddress.anyIPv6;
  final port = int.tryParse(Platform.environment['PORT'] ?? '8080') ?? 8080;
  createServer(address, port);
}

Future<HttpServer> createServer(InternetAddress address, int port) async {
  final handler = Cascade().add(buildRootHandler()).handler;
  final server = await serve(handler, address, port);
  print('\x1B[92m✓\x1B[0m Running on http://${server.address.host}:${server.port}');
  return server;
}

Handler buildRootHandler() {
  final pipeline = const Pipeline().addMiddleware(middleware.middleware);
  final router = Router()
    ..mount('/items', (context) => buildItemsHandler()(context))
    ..mount('/lists', (context) => buildListsHandler()(context))
    ..mount('/user', (context) => buildUserHandler()(context))
    ..mount('/', (context) => buildHandler()(context));
  return pipeline.addHandler(router);
}

Handler buildItemsHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => items_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildListsHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => lists_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildUserHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => user_index.onRequest(context,))..all('/<id>', (context,id,) => user_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => index.onRequest(context,));
  return pipeline.addHandler(router);
}

