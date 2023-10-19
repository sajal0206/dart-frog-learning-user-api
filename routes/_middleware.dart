import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/constants/my_prisma_client.dart';
import 'package:tasklist_backend/src/generated/prisma/prisma_client.dart';
import 'package:tasklist_backend/user/user_repository.dart';

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(
        _providePrisma(),
      )
      .use(
        _provideUserRepo(),
      );
}

/// prism middlwware
Middleware _providePrisma() {
  final prisma = myPrismaClient;
  return provider<PrismaClient>(
    (context) => prisma,
  );
}

/// user repo middlwware
Middleware _provideUserRepo() {
  final prisma = myPrismaClient;
  return provider<UserRepository>(
    (context) => UserRepository(
      prisma,
    ),
  );
}
