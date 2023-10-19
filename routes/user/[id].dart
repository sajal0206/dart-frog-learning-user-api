import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/src/generated/prisma/prisma_client.dart';
import 'package:tasklist_backend/user/user_repository.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  return switch (context.request.method) {
    HttpMethod.get => await _getSpecificUsers(context, id),
    HttpMethod.put => await _updateUser(context, id),
    HttpMethod.delete => await _deleteUser(context, id),
    _ => Response(
        body: '${context.request.method.name} is not allowed now',
      ),
  };
}

Future<Response> _getSpecificUsers(RequestContext context, String id) async {
  final userId = id;
  try {
    final data =
        await context.read<UserRepository>().getUniqueUser(int.parse(userId));
    if (data.isNotEmpty) {
      return Response.json(
        body: data,
      );
    } else {
      return Response.json(
        body: {
          'message': 'User Does Not Exist With Id: $userId',
        },
        statusCode: HttpStatus.noContent,
      );
    }
  } catch (e) {
    return Response.json(
      body: {
        'message': 'Invalid Id: $userId',
      },
      statusCode: HttpStatus.badRequest,
    );
  }
}

Future<Response> _updateUser(RequestContext context, String id) async {
  final userId = int.parse(id);
  final prisma = context.read<PrismaClient>();
  final data = jsonDecode(await context.request.body()) as Map<String, dynamic>;

  try {
    final item = await prisma.user.update(
      data: UserUpdateInput(
        age: IntFieldUpdateOperationsInput(
          set: data['age'] as int,
        ),
        email: StringFieldUpdateOperationsInput(
          set: data['email'].toString(),
        ),
        name: StringFieldUpdateOperationsInput(
          set: data['name'].toString(),
        ),
      ),
      where: UserWhereUniqueInput(
        id: userId,
      ),
    );
    return Response.json(
      body: {
        'message': 'User Updated Successfully',
        'user': item,
      },
      statusCode: HttpStatus.badRequest,
    );
  } catch (e) {
    return Response.json(
      body: {
        'message': e,
      },
      statusCode: HttpStatus.badRequest,
    );
  }
}

Future<Response> _deleteUser(RequestContext context, String id) async {
  try {
    final userId = int.parse(id);
    final item = await context.read<UserRepository>().deleteUser(userId);
    return Response.json(
      body: {'message': 'User deleted successfully', 'user': item},
    );
  } catch (e) {
    return Response.json(
      body: {
        'message': e,
      },
      statusCode: HttpStatus.badRequest,
    );
  }
}
