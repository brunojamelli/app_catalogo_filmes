import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../models/filme.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  static Database? _database;

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'filmes.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE filmes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT,
        ano INTEGER,
        direcao TEXT,
        resumo TEXT,
        url_cartaz TEXT,
        nota REAL
      )
    ''');
  }

  Future<List<Filme>> getFilmes() async {
    final db = await database;
    final data = await db.query('filmes');
    return data.map((map) => Filme.fromMap(map)).toList();
  }

  Future<void> insertFilme(Filme filme) async {
    final db = await database;
    await db.insert('filmes', filme.toMap());
  }

  Future<void> updateFilme(Filme filme) async {
    final db = await database;
    await db.update('filmes', filme.toMap(), where: 'id = ?', whereArgs: [filme.id]);
  }

  Future<void> deleteFilme(int id) async {
    final db = await database;
    await db.delete('filmes', where: 'id = ?', whereArgs: [id]);
  }
}