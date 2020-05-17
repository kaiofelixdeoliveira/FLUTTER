import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_sqlite/app/modules/home/enums/database.enum.dart';


class DatabaseHelper {
// torna esta classe singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  // tem somente uma referência ao banco de dados
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // instancia o db na primeira vez que for acessado
    _database = await _initDatabase();
    return _database;
  }

  // abre o banco de dados e o cria se ele não existir
  static _initDatabase() async {
    try {
      String path = join(
          await getDatabasesPath(), DatabaseHelperEnum.getValue(DATABASE.name));
      await deleteDatabase(path);
      return await openDatabase(path,
          version: DatabaseHelperEnum.getValue(DATABASE.version),
          onCreate: _onCreate,
          onConfigure: _onConfigure);
    } catch (error) {
      print(error);
    }
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
    print('Foreign keys turned on');
  }

  // Código SQL para criar o banco de dados e a tabela
  static Future _onCreate(Database db, int version) async {
    var sql = [

      '''DROP TABLE IF EXISTS dog;''',
      '''DROP TABLE IF EXISTS canil;''',
      '''create table if not exists dog (
            id integer primary key autoincrement,
            name text,
            date_modification datetime,
            date_create datetime
            );''',
      '''create table if not exists canil (
            id integer primary key autoincrement,
            name text,
            date_modification datetime,
            date_create datetime,
            dog_id int NOT NULL,
            foreign key (dog_id) references dog (id) ON DELETE CASCADE
            );''',
    
      '''insert into dog (name,date_create) values('pit bull',strftime('%d-%m-%Y %H:%M:%S', datetime('now')));''',
      '''insert into dog (name,date_create) values('dalmatas',strftime('%d-%m-%Y %H:%M:%S', datetime('now')));''',
      '''insert into dog (name,date_create) values('poodle',strftime('%d-%m-%Y %H:%M:%S', datetime('now')));''',
      '''insert into canil (name,date_create, dog_id)
             values('canil de osasco',strftime('%d-%m-%Y %H:%M:%S', datetime('now')),1);''',
      '''insert into canil (name,date_create, dog_id)
             values('canil de lavras',strftime('%d-%m-%Y %H:%M:%S', datetime('now')),2);''',
      '''insert into canil (name,date_create, dog_id)
             values('canil de paraisópolis',strftime('%d-%m-%Y %H:%M:%S', datetime('now')),3);''',
     
    ];

    for (var i = 0; i < sql.length; i++) {
      print("execute sql : " + sql[i]);
      await db.execute(sql[i]).catchError((onError) => print(onError));
    }
  }
}
