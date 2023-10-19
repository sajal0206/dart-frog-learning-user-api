import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/constants/my_prisma_client.dart';
import 'package:tasklist_backend/src/generated/prisma/prisma_client.dart';

Handler middleware(Handler handler) {
  final prisma = myPrismaClient;
  return handler.use(requestLogger()).use(
        provider<PrismaClient>(
          (context) => prisma,
        ),
      );
}
