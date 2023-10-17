import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/user/user_model.dart';
import 'package:tasklist_backend/users.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => _getUsers(),
    HttpMethod.post => await _addNewUser(context),
    _ => Response(body: '${context.request.method.name} is not allowed now'),
  };
}

Response _getUsers() {
  return Response.json(
    body: users,
  );
}

Future<Response> _addNewUser(RequestContext context) async {
  final data = jsonDecode(await context.request.body()) as Map<String, dynamic>;
  if (data['id'] != null &&
      data['name'] != null &&
      data['age'] != null &&
      data['email'] != null) {
    final userModel = UserModel.fromJson(data);
    if (users.any((element) => element.id == userModel.id)) {
      return Response.json(
        body: {
          'message':
              'id ${userModel.id} already exists please choose any other',
        },
      );
    } else {
      users.add(userModel);
      return Response.json(
        body: {
          'message': 'User Added Successfully',
          'user': userModel.toJson(),
        },
      );
    }
  } else {
    return Response.json(
      body: {
        'message': 'Please provide all required fields',
        'fields': {
          'id': 'Required with type String/ Character',
          'name': 'Required with type String/ Character',
          'age': 'Required with type double/ float',
          'email': 'Required with type String/ Character',
        },
      },
    );
  }
}
