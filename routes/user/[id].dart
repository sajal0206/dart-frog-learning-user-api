import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/user/user_model.dart';
import 'package:tasklist_backend/users.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  return switch (context.request.method) {
    HttpMethod.get => _getSpecificUsers(context, id),
    HttpMethod.put => await _updateUser(context, id),
    HttpMethod.delete => await _deleteUser(context, id),
    _ => Response(
        body: '${context.request.method.name} is not allowed now',
      ),
  };
}

Response _getSpecificUsers(RequestContext context, String id) {
  final userId = id;
  if (users.any((element) => element.id.toString() == userId)) {
    return Response.json(
      body: users.firstWhere((element) => element.id.toString() == userId),
    );
  } else {
    return Response.json(
      body: {
        'message': 'User Does Not Exist With This Id',
      },
    );
  }
}

Future<Response> _updateUser(RequestContext context, String id) async {
  final userId = id;
  if (users.any((element) => element.id.toString() == userId)) {
    final data =
        jsonDecode(await context.request.body()) as Map<String, dynamic>;
    final existingUserModel =
        users.firstWhere((element) => element.id.toString() == userId);
    final userModel = UserModel(
      id: existingUserModel.id,
      userName: data['name'] != null
          ? data['name'].toString()
          : existingUserModel.userName,
      email: data['email'] != null
          ? data['email'].toString()
          : existingUserModel.email,
      age: data['age'] != null ? data['age'] as int : existingUserModel.age,
    );
    users[users.indexWhere((element) => element.id.toString() == userId)] =
        userModel;
    return Response.json(
      body: {
        'message': 'User Updated Successfully',
        'user': userModel,
      },
    );
  } else {
    return Response.json(
      body: {
        'message': 'User Does Not Exist With This Id',
      },
    );
  }
}

Future<Response> _deleteUser(RequestContext context, String id) async {
  final userId = id;
  users.removeWhere((element) => element.id.toString() == userId);
  return Response.json(
    body: {
      'message': 'User deleted successfully',
    },
  );
}
