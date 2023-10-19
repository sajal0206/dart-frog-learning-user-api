import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/constants/connection.dart';
import 'package:tasklist_backend/src/generated/prisma/prisma_client.dart';
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

/// to add user directly into the list
// Future<Response> _addNewUser(RequestContext context) async {
//   final data = jsonDecode(await context.request.body()) as Map<String, dynamic>;
//   if (data['id'] != null &&
//       data['name'] != null &&
//       data['age'] != null &&
//       data['email'] != null) {
//     final userModel = UserModel.fromJson(data);
//     if (users.any((element) => element.id == userModel.id)) {
//       return Response.json(
//         body: {
//           'message':
//               'id ${userModel.id} already exists please choose any other',
//         },
//       );
//     } else {
//       users.add(userModel);
//       return Response.json(
//         body: {
//           'message': 'User Added Successfully',
//           'user': userModel.toJson(),
//         },
//       );
//     }
//   } else {
//     return Response.json(
//       body: {
//         'message': 'Please provide all required fields',
//         'fields': {
//           'id': 'Required with type String/ Character',
//           'name': 'Required with type String/ Character',
//           'age': 'Required with type double/ float',
//           'email': 'Required with type String/ Character',
//         },
//       },
//     );
//   }
// }

/// create user into the database
Future<Response> _addNewUser(RequestContext context) async {
  final data = jsonDecode(await context.request.body()) as Map<String, dynamic>;
  if (data['name'] != null && data['age'] != null && data['email'] != null) {
    // users.add(userModel);
    final prisma = PrismaClient(
      datasources: const Datasources(
        db: connection,
      ),
    );
    try {
      final userModel = await prisma.user.create(
        data: UserCreateInput.fromJson(
          data,
        ),
      );
      return Response.json(
        body: {
          'message': 'User Added Successfully',
          'user': userModel.toJson(),
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
