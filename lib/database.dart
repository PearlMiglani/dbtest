import 'package:movielist/model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class mdata {
 static final mdata instance = mdata._init();
 static Database? _db;
  mdata._init();
  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await _initDB('mdatabase.db');
    return _db!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: createtable);
  }

  Future createtable(Database db, int version) async {
    
    await db.execute('''CREATE TABLE mdb (id INTEGER PRIMARY KEY, mname TEXT, dname TEXT, img TEXT)''');
    }

  Future<MovieModel> insert(MovieModel movie) async {
    final db = await instance.database;
    final id = await db.insert('mdb', movie.toJson());
    return movie.copy();  
    }

  Future<List<MovieModel>> movielist() async {
    final db = await instance.database;
    final movies = await db.query('mdb');
    return movies.map((json) => MovieModel.fromJson(json)).toList();
  }

  Future<int> update(MovieModel movie) async {
    final db = await instance.database;
    return db.update(
      'mdb',
      movie.toJson(),
      where: 'id = ?',
      whereArgs: [movie.id],
      );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return db
      .delete('mdb', where: 'id = ?', whereArgs: [id]);
  }

  Future _close() async {
    final db = await instance.database;
    db.close();
  }
}