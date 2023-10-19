import 'package:tasklist_backend/src/generated/prisma/prisma_client.dart';

/// user repository
class UserRepository {
  /// constructor for the user repository
  UserRepository(
    this._db,
  );

  /// prisma client database
  final PrismaClient _db;

  /// function to create new user using prisma client into the database
  Future<User?> createNewUser(Map<String, dynamic> data) async {
    final user = await _db.user.create(
      data: UserCreateInput.fromJson(
        data,
      ),
    );
    return user;
  }

  /// function to get users using prisma client from the database
  Future<List<User>> getAllUsers() async {
    final user = (await _db.user.findMany()).toList();
    return user;
  }

  /// function to delete user from prisma client database
  Future<User?> deleteUser(int id) async {
    final user = await _db.user.delete(
      where: UserWhereUniqueInput(
        id: id,
      ),
    );
    return user;
  }

  /// get user from id
  Future<List<User>> getUniqueUser(int userId) async {
    final users = (await _db.user.findMany(
      where: UserWhereInput(
        id: IntFilter(
          equals: userId,
        ),
      ),
    ))
        .toList();
    return users;
  }
}
