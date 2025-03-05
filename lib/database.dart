import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'meus_filmes.db');
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
        titulo TEXT NOT NULL,
        ano INTEGER NOT NULL,
        direcao TEXT NOT NULL,
        resumo TEXT NOT NULL,
        url_cartaz TEXT,
        nota REAL NOT NULL
      )
    ''');

    // Pré-inserir alguns filmes
    await _preencherBanco(db);
  }

  Future<void> _preencherBanco(Database db) async {
    await db.insert('filmes', {
      'titulo': 'O Poderoso Chefão',
      'ano': 1972,
      'direcao': 'Francis Ford Coppola',
      'resumo': 'A saga da família Corleone.',
      'url_cartaz': 'https://image.tmdb.org/t/p/w500/rPdtL9s8cUROZK1hRflLQ9f7VnW.jpg',
      'nota': 5.0,
    });

    await db.insert('filmes', {
      'titulo': 'O Senhor dos Anéis: A Sociedade do Anel',
      'ano': 2001,
      'direcao': 'Peter Jackson',
      'resumo': 'Uma jornada épica para destruir o Um Anel.',
      'url_cartaz': 'https://image.tmdb.org/t/p/w500/8ZBY6YR9QYVDWX4Z3zQvJz4ZzZz.jpg',
      'nota': 4.5,
    });

    await db.insert('filmes', {
      'titulo': 'Interestelar',
      'ano': 2014,
      'direcao': 'Christopher Nolan',
      'resumo': 'Uma jornada pelo espaço em busca de um novo lar.',
      'url_cartaz': 'https://image.tmdb.org/t/p/w500/nBNZadXqJSdt05SHLqgT0HuC5Gm.jpg',
      'nota': 4.7,
    });
  }

  Future<List<Map<String, dynamic>>> getFilmes() async {
    Database db = await database;
    return await db.query('filmes');
  }

  Future<int> insertFilme(Map<String, dynamic> filme) async {
    Database db = await database;
    return await db.insert('filmes', filme);
  }

  Future<int> updateFilme(Map<String, dynamic> filme) async {
    Database db = await database;
    return await db.update('filmes', filme, where: 'id = ?', whereArgs: [filme['id']]);
  }
  
   Future<int> deleteFilme(int id) async {
    Database db = await database;
    return await db.delete('filmes', where: 'id = ?', whereArgs: [id]);
  }
}