import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/user/user_repository.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => await _getUsers(context),
    HttpMethod.post => await _addNewUser(context),
    _ => Response(body: '${context.request.method.name} is not allowed now'),
  };
}

Future<Response> _getUsers(RequestContext context) async {
  final users = await context.read<UserRepository>().getAllUsers();
  return Response.json(
    body: users,
  );
}

/// create user into the database
Future<Response> _addNewUser(RequestContext context) async {
  final data = jsonDecode(await context.request.body()) as Map<String, dynamic>;
  if (data['name'] != null && data['age'] != null && data['email'] != null) {
    final userRepo = context.read<UserRepository>();
    try {
      final userModel = await userRepo.createNewUser(
        data,
      );
      return Response.json(
        body: {
          'message': 'User Added Successfully',
          'user': userModel,
        },
        statusCode: HttpStatus.accepted,
      );
    } catch (e) {
      return Response.json(
        body: {
          'message': 'Internal Server Error',
          'Error': e,
        },
        statusCode: HttpStatus.internalServerError,
      );
    }
  } else {
    return Response.json(
      body: {
        'message': 'Please provide all required fields',
        'fields': {
          'name': 'Required with type String/ Character',
          'age': 'Required with type double/ float',
          'email': 'Required with type String/ Character',
        },
      },
      statusCode: HttpStatus.conflict,
    );
  }
}
