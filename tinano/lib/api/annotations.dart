import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

/// Annotation for your database classes to provide the name of the database in
/// the file system and the current schema version.
class DatabaseInfo {
  // note: When performing refactorings of this class, also adapt usages in
  // generator (defined_database.dart).

  /// The filename of this database.
  final String name;
  final int schemaVersion;

  const DatabaseInfo({@required this.name, this.schemaVersion = 1});
}

class OnCreate {
  const OnCreate._();
}

/// Annotation for a method in your database class that will be invoked when
/// the database is created for the first time. The method must return a
/// `Future<void>` that completes after the initialization has been completed.
/// It must have one parameter of the type [Database]. An example might look
/// like this:
/// ```
/// @onCreate
/// Future<void> _onDbCreated(Database db) {
///   await db.execute("""CREATE TABLE `todos` (
///          `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
///          `content` TEXT NOT NULL
///        )""");
/// }
/// ```
const onCreate = OnCreate._();

/// Annotation for a method in your database class that will be invoked when the
/// database performs a version upgrade (that is, in your [DatabaseInfo], you
/// increased the [DatabaseInfo.schemaVersion] and re-run your app). Tinano will
/// figure out which schema upgrade methods to call in which order. The method
/// must return a `Future<void>` and it must have one parameter of the type
/// [Database]. An example might look like this:
/// ```
/// @OnUpgrade(from: 1, to: 2)
/// Future<void> _dbUpgraded1_2(Database db) {
///   await db.execute("ALTER TABLE ...");
/// }
/// ```
class OnUpgrade {

  /// The schema version from which we can perform the upgrade
  final int from;
  /// The schema version after this upgrade (migration) has been applied.
  final int to;

  const OnUpgrade({@required this.from, @required this.to});

}

class Row {
  const Row._();
}

/// Use the row annotation to mark non-primitive data structures that can be
/// returned by one of your queries. Check the readme of tinano for details on
/// how to use this class exactly.
const row = Row._();

abstract class DatabaseAction {
  final String sql;

  const DatabaseAction(this.sql);
}

class Update extends DatabaseAction {
  const Update(String sql) : super(sql);
}

class Delete extends DatabaseAction {
  const Delete(String sql) : super(sql);
}

class Insert extends DatabaseAction {
  const Insert(String sql) : super(sql);
}

class Query extends DatabaseAction {
  const Query(String sql) : super(sql);
}
