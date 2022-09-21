import 'package:focus_time/core/errors/errors_exceptions.dart';
import 'package:focus_time/core/user/current_user.dart';
import 'package:focus_time/features/auth/data/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

class MySqfliteAPI {
  static String LOCAL_DATABASE_NAME = 'focus_time.db';
  static late Database localDatabase;

  static Future<void> initLocalDatabase() async {
    // open the database
    localDatabase = await openDatabase(
      LOCAL_DATABASE_NAME,
      version: 1,
      onOpen: (database) async {},
      onCreate: (database, version) async {
        // When creating the db, create the table
        await database.execute(
          'CREATE TABLE users (userId TEXT PRIMARY KEY,'
          'firstName TEXT, lastName TEXT, email TEXT,'
          'password TEXT, phone TEXT, birthdate TEXT,'
          'gender TEXT,avaterPath TEXT)',
        );
        await database.execute(
          'CREATE TABLE current_user (userId TEXT PRIMARY KEY,'
          'firstName TEXT, lastName TEXT, email TEXT,'
          'password TEXT, phone TEXT, birthdate TEXT,'
          'gender TEXT,avaterPath TEXT)',
        );
      },
    );
  }

  static void dropDatabase() async {
    await localDatabase.execute('DROP TABLE users');
  }

  static Future<void> localSignIn(UserModel user) async {
    try {
      await localDatabase.insert('users', user.toDatabase());
      await localDatabase.insert('current_user', user.toDatabase());
    } on DatabaseException catch (e) {
      if (e.isUniqueConstraintError()) {
        throw InsertingExistsUserException();
      } else if (e.isNotNullConstraintError()) {
        throw InsertingNullException();
      }
    } catch (e) {
      throw UnexpectedDatabaseException();
    }
  }

  static Future<Map<String, dynamic>> getUser(String id) async {
    try {
      final storedUser = await localDatabase
          .rawQuery('SELECT * FROM users WHERE userId = \'$id\'');
      return storedUser[0];
    } catch (e) {
      print("--------------");
      print(e);
      throw UnexpectedDatabaseException();
    }
  }

  static Future<Map<String, dynamic>> getCurrentUser(String id) async {
    try {
      final storedUser = await localDatabase
          .rawQuery('SELECT * FROM current_user WHERE userId = \'$id\'');
      return storedUser[0];
    } catch (e) {
      throw UnexpectedDatabaseException();
    }
  }

  static Future<List<Map<String, dynamic>>> getAllUser() async {
    try {
      final storedUser = await localDatabase.rawQuery('SELECT * FROM users');
      return storedUser;
    } catch (e) {
      throw UnexpectedDatabaseException();
    }
  }

  static Future<UserModel> localLogin({
    required String email,
    required String password,
  }) async {
    try {
      final response = await localDatabase.rawQuery(
          'SELECT COUNT(1) FROM users WHERE email = \'$email\' and password = \'$password\'');
      if (response[0]['COUNT(1)'] == 1) {
        final storedUser = await localDatabase.rawQuery(
            'SELECT * FROM users WHERE email = \'$email\' and password = \'$password\'');
        final user = UserModel.fromDatabase(storedUser[0]);
        await saveCurrentUser(user);
        return user;
      } else {
        throw AuthLocalUserNotFountException();
      }
    } catch (e) {
      throw UnexpectedDatabaseException();
    }
  }

  static Future<int> saveCurrentUser(UserModel user) =>
      localDatabase.insert('current_user', user.toDatabase());

  static Future<void> localLogOut() async {
    await localDatabase.delete('current_user');
    return;
  }

  static Future<void> getLogedUser() async {
    try {
      final storedUser =
          await localDatabase.rawQuery('SELECT * FROM current_user');
      if (storedUser.length == 1) {
        CurrentUser.set(UserModel.fromDatabase(storedUser[0]));
      }
    } catch (e) {
      throw UnexpectedDatabaseException();
    }
  }

  static Future<void> updateUser(UserModel user) async {
    try {
      await localDatabase.update('users', user.toDatabase(),
          where: 'userId = ?', whereArgs: [user.userId]);
      await localDatabase.update('current_user', user.toDatabase(),
          where: 'userId = ?', whereArgs: [user.userId]);
    } on DatabaseException catch (e) {
      if (e.isUniqueConstraintError()) {
        throw InsertingExistsUserException();
      } else if (e.isNotNullConstraintError()) {
        throw InsertingNullException();
      }
    } catch (e) {
      throw UnexpectedDatabaseException();
    }
  }
}
