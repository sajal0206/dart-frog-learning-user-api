import 'package:mysql_utils/mysql_utils.dart';

/// user repository
class UserRepository {
  /// constructor for the user repository
  UserRepository(
    this._db,
  );

  /// prisma client database
  final MysqlUtils _db;

  /// function to create new user using prisma client into the database
  Future<Map<String, dynamic>> createNewUser(Map<String, dynamic> data) async {
    final userId = await _db.insert(
      table: 'user',
      insertData: {
        'name': data['name'],
        'email': data['email'],
        'age': data['age'],
      },
    );
    final userData = await _db.getOne(
      table: 'user',
      where: {
        'id': userId,
      },
    );
    return userData as Map<String, dynamic>;
  }

  /// function to create new user using prisma client into the database
  Future<Map<String, dynamic>> updateOldUser(
    Map<String, dynamic> data,
    int id,
  ) async {
    final state = await _db.update(
      table: 'user',
      updateData: {
        'name': data['name'],
        'email': data['email'],
        'age': data['age'],
      },
      where: {
        'id': id,
      },
    );
    if (state == 1) {
      final userData = await _db.getOne(
        table: 'user',
        where: {
          'id': id,
        },
      );
      return userData as Map<String, dynamic>;
    } else {
      return {};
    }
  }

  /// function to get users using prisma client from the database
  Future<List<dynamic>> getAllUsers() async {
    final user = (await _db.getAll(table: 'user')).toList();
    return user;
  }

  /// function to delete user from prisma client database
  Future<int?> deleteUser(int id) async {
    final user = await _db.delete(
      table: 'user',
      where: {
        'id': id,
      },
    );
    return user;
  }

  /// get user from id
  Future<Map<String, dynamic>> getUniqueUser(int userId) async {
    final user = await _db.getOne(
      table: 'user',
      where: {
        'id': userId,
      },
    );
    if (user.isNotEmpty) {
      return user as Map<String, dynamic>;
    } else {
      return {};
    }
  }
}
