
import 'package:meuscheques/app/global/constants.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseProvider {
  DataBaseProvider._();
  static final DataBaseProvider db = DataBaseProvider._();

  Database _database;
  //DatabaseFactory _databaseFactory;
  deleteAll() async {
    final db = await database;
    db.rawDelete("DELETE from cheques");
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(join(dbPath, 'dados.db'), version: 1,
        onCreate: (Database database, int version) async {
      

      await database.execute("CREATE TABLE $BANK_TABLE ("
          "$BANK_NAME TEXT,"
          "$BANK_NUMBER INTEGER PRIMARY KEY"
          
          ")");

          //"PRIMARY KEY ($MYMOVIES_ID, $MYMOVIES_ID_PROFILE)"
      await database.execute("CREATE TABLE $BANK_ACCOUNT_TABLE ("
          "$BANK_ACCOUNT_ID INTEGER PRIMARY KEY,"
          "$BANK_ACCOUNT_NAME TEXT,"
          "$BANK_ACCOUNT_AGENCY INTEGER,"
          "$BANK_ACCOUNT_NUMBER INTEGER,"
          "$ACCOUNT_BANK_NUMBER INTEGER,"
          "UNIQUE ($BANK_ACCOUNT_AGENCY, $BANK_ACCOUNT_NUMBER, $ACCOUNT_BANK_NUMBER)"
          ")");

      await database.execute("CREATE TABLE $CHEQUE_TABLE ("
          "$CHEQUE_NUMBER INTEGER,"
          "$CHEQUE_ACCOUNT_ID INTEGER,"
          "$CHEQUE_VALUE REAL,"
          "$CHEQUE_STATUS TEXT,"
          "$CHEQUE_DATE INTEGER,"
          "PRIMARY KEY ($CHEQUE_NUMBER, $CHEQUE_ACCOUNT_ID)"
          ")");
    });
  }
}
