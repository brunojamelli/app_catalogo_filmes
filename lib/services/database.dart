import 'dart:math';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/filme.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  static Database? _database;

  final List<String> _urlsCartaz = [
    'https://image.tmdb.org/t/p/w500/nBNZadXqJSdt05SHLqgT0HuC5Gm.jpg',
    'https://image.tmdb.org/t/p/w500/oJagOzBu9Rdd9BrciseCm3U3MCU.jpg',
    'https://image.tmdb.org/t/p/w500/1ynI5svKuPEFCIQeUgNxr1n8ZJ7.jpg',
    'https://image.tmdb.org/t/p/w500/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg',
    'https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg',
  ];

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

    // Filmes pré-cadastrados
    await db.insert('filmes', {
      'titulo': 'Interestelar',
      'ano': 2014,
      'direcao': 'Christopher Nolan',
      'resumo': 'Um grupo de astronautas viaja através de um buraco de minhoca em busca de um novo lar para a humanidade.',
      'url_cartaz': _urlsCartaz[0],
      'nota': 4.5,
    });

    await db.insert('filmes', {
      'titulo': 'O Poderoso Chefão',
      'ano': 1972,
      'direcao': 'Francis Ford Coppola',
      'resumo': 'A história da família mafiosa Corleone, com foco no patriarca Vito Corleone e seu filho Michael.',
      'url_cartaz': _urlsCartaz[1],
      'nota': 4.7,
    });

    await db.insert('filmes', {
      'titulo': 'Clube da Luta',
      'ano': 1999,
      'direcao': 'David Fincher',
      'resumo': 'Um homem deprimido forma um clube de luta clandestino como uma forma de terapia alternativa.',
      'url_cartaz': _urlsCartaz[2],
      'nota': 4.3,
    });
  }

  String getRandomUrlCartaz() {
    final random = Random();
    return _urlsCartaz[random.nextInt(_urlsCartaz.length)];
  }

  Future<List<Filme>> getFilmes() async {
    final db = await database;
    final data = await db.query('filmes');
    return data.map((map) => Filme.fromMap(map)).toList();
  }

  Future<void> insertFilme(Filme filme) async {
    final db = await database;
    await db.insert('filmes', {
      'titulo': filme.titulo,
      'ano': filme.ano,
      'direcao': filme.direcao,
      'resumo': filme.resumo,
      'url_cartaz': getRandomUrlCartaz(),
      'nota': filme.nota,
    });
  }

  Future<void> updateFilme(Filme filme) async {
    final db = await database;
    await db.update('filmes', {
      'titulo': filme.titulo,
      'ano': filme.ano,
      'direcao': filme.direcao,
      'resumo': filme.resumo,
      'url_cartaz': filme.urlCartaz,
      'nota': filme.nota,
    }, where: 'id = ?', whereArgs: [filme.id]);
  }

  Future<void> deleteFilme(int id) async {
    final db = await database;
    await db.delete('filmes', where: 'id = ?', whereArgs: [id]);
  }
}