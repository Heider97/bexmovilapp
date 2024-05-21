part of '../app_database.dart';

Future<void> onCreate(db, version) async {
  await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableLocations (
      ${LocationFields.id} INTEGER PRIMARY KEY,
      ${LocationFields.latitude} REAL DEFAULT NULL,
      ${LocationFields.longitude} REAL DEFAULT NULL,
      ${LocationFields.accuracy} REAL DEFAULT NULL,
      ${LocationFields.altitude} REAL DEFAULT NULL,
      ${LocationFields.speed} REAL DEFAULT NULL,
      ${LocationFields.speedAccuracy} REAL DEFAULT NULL,
      ${LocationFields.heading} REAL DEFAULT NULL,
      ${LocationFields.isMock} BOOLEAN DEFAULT NULL
    )
  ''');
  await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableProcessingQueues (
      ${ProcessingQueueFields.id} INTEGER PRIMARY KEY,
      ${ProcessingQueueFields.body} TEXT DEFAULT NULL,
      ${ProcessingQueueFields.task} TEXT DEFAULT NULL,
      ${ProcessingQueueFields.code} TEXT DEFAULT NULL,
      ${ProcessingQueueFields.error} TEXT DEFAULT NULL,
      ${ProcessingQueueFields.createdAt} TEXT DEFAULT NULL,
      ${ProcessingQueueFields.updatedAt} TEXT DEFAULT NULL
    )
  ''');
  await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableConfig (
      ${ConfigFields.id} INTEGER PRIMARY KEY,
      ${ConfigFields.name} TEXT DEFAULT NULL,
      ${ConfigFields.type} TEXT DEFAULT NULL,
      ${ConfigFields.value} TEXT DEFAULT NULL,
      ${ConfigFields.module} TEXT DEFAULT NULL
    )
  ''');
  await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableApplications (
      ${ApplicationFields.id} INTEGER PRIMARY KEY,
      ${ApplicationFields.title} TEXT DEFAULT NULL,
      ${ApplicationFields.svg} TEXT DEFAULT NULL,
      ${ApplicationFields.route} TEXT DEFAULT NULL,
      ${ApplicationFields.enabled} BOOLEAN DEFAULT NULL
    )
  ''');
  await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableErrors (
      ${ErrorFields.id} INTEGER PRIMARY KEY,
      ${ErrorFields.errorMessage} TEXT DEFAULT NULL,
      ${ErrorFields.stackTrace}  TEXT DEFAULT NULL,
      ${ErrorFields.createdAt} TEXT DEFAULT NULL
    )
  ''');
  await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableFilter (
      ${FilterFields.id} INTEGER PRIMARY KEY,
      ${FilterFields.name} TEXT DEFAULT NULL,
      ${FilterFields.module}  TEXT DEFAULT NULL,
      ${FilterFields.type} TEXT DEFAULT NULL
    )
  ''');
  await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableOption (
      ${OptionFields.id} INTEGER PRIMARY KEY,
      ${OptionFields.name} TEXT DEFAULT NULL,
      ${OptionFields.type} TEXT DEFAULT NULL,
      ${OptionFields.order} INTEGER DEFAULT NULL,
      ${OptionFields.filterId} INTEGER DEFAULT NULL,
      ${OptionFields.queryId} INTEGER DEFAULT NULL
    )
  ''');
  await db.execute('''
      CREATE TABLE IF NOT EXISTS polylines (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      codeRouter TEXT, polylines TEXT
      )
    ''');
  await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableFeature (
      ${FeaturesFields.coddashboard} INTEGER PRIMARY KEY,
      ${FeaturesFields.codvendedor} TEXT DEFAULT NULL,
      ${FeaturesFields.descripcion} TEXT DEFAULT NULL,
      ${FeaturesFields.urldesc} TEXT DEFAULT NULL,
      ${FeaturesFields.categoria} TEXT DEFAULT NULL,
      ${FeaturesFields.codcliente} TEXT DEFAULT NULL,
      ${FeaturesFields.fechaevento} TEXT DEFAULT NULL,
      ${FeaturesFields.fechafinevento} TEXT DEFAULT NULL,
      ${FeaturesFields.fecgra} TEXT DEFAULT NULL,
      ${FeaturesFields.requerido} TEXT DEFAULT NULL,
      ${FeaturesFields.createdById} INTEGER DEFAULT NULL,
      ${FeaturesFields.createdAt} TEXT DEFAULT NULL,
      ${FeaturesFields.updatedAt} TEXT DEFAULT NULL,
      ${FeaturesFields.deletedAt} TEXT DEFAULT NULL
    )
  ''');
  await db.execute('''
    CREATE TABLE IF NOT EXISTS app_cart (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      codrouter TEXT NOT NULL,
      codPrecio TEXT NOT NULL,
      codBodega TEXT NOT NULL,
      codcliente TEXT NOT NULL,
      codproducts TEXT NOT NULL,
      state TEXT NOT NULL,
      date TEXT NOT NULL
    )
  ''');

  await db.execute('''
      CREATE TABLE IF NOT EXISTS app_cart_stock (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cart_id INTEGER NOT NULL,
        product_id TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        FOREIGN KEY(cart_id) REFERENCES app_cart(id)
      )
    ''');
}
