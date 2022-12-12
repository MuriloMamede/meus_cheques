class DataBaseProvider {
  /*DataBaseProvider._();
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

      BANCOS.forEach((element) async {
        await database.insert(BANK_TABLE, element);
      });

/*
      //"PRIMARY KEY ($MYMOVIES_ID, $MYMOVIES_ID_PROFILE)"
      await database.execute("CREATE TABLE $BANK_ACCOUNT_TABLE ("
          "$BANK_ACCOUNT_ID INTEGER PRIMARY KEY,"
          "$BANK_ACCOUNT_NAME TEXT,"
          "$BANK_ACCOUNT_AGENCY INTEGER,"
          "$BANK_ACCOUNT_NUMBER INTEGER,"
          "$ACCOUNERT_BANK_NAME INTEGER,"
          "UNIQUE ($BANK_ACCOUNT_AGENCY, $BANK_ACCOUNT_NUMBER, $ACCOUNERT_BANK_NAME)"
          ")");

      await database.execute("CREATE TABLE $CHEQUE_TABLE ("
          "$CHEQUE_NUMBER INTEGER,"
          "$CHEQUE_ACCOUNT INTEGER,"
          "$CHEQUE_VALUE REAL,"
          "$CHEQUE_STATUS TEXT,"
          "$CHEQUE_DATE INTEGER,"
          "PRIMARY KEY ($CHEQUE_NUMBER, $CHEQUE_ACCOUNT)"
          ")");*/
    });
  }*/
}
