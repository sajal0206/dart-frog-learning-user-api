import 'package:tasklist_backend/src/generated/prisma/prisma_client.dart';

/// Prisma client
PrismaClient myPrismaClient = PrismaClient(
  datasources: const Datasources(
    db: 'mysql://root:@localhost:3306/dartFrogDb?schema=public',
  ),
);
