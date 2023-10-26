import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/constants/mySqlConnection.dart';
import 'package:tasklist_backend/user/user_repository.dart';

Handler middleware(Handler handler) {
  return handler.use(requestLogger()).use(
        _provideUserRepo(),
      );
}

/// user repo middlwware
Middleware _provideUserRepo() {
  final db = mySqlConnection;
  return provider<UserRepository>(
    (context) => UserRepository(
      db,
    ),
  );
}
