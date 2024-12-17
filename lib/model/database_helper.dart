import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'my_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('PRAGMA foreign_keys = ON;');
    await db.execute('''
      CREATE TABLE user (
        user_id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL UNIQUE,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        point INTEGER DEFAULT 0,
        fullname TEXT,
        dob DATE,
        gender TEXT,
        avatar TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE categories (
        category_id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE,
        icon TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE foods (
        food_id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        description TEXT,
        is_best_seller BOOLEAN DEFAULT 0,
        image TEXT,
        FOREIGN KEY (category_id) REFERENCES categories (category_id) ON DELETE CASCADE
      );
    ''');
    await db.execute('''
      CREATE TABLE promotion (
        promotion_id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        image TEXT,
        start_date DATE NOT NULL,
        end_date DATE NOT NULL
      );
    ''');
    await db.execute('''
      CREATE TABLE promotion_food (
        promotion_id INTEGER NOT NULL,
        food_id INTEGER NOT NULL,
        PRIMARY KEY (promotion_id, food_id),
        FOREIGN KEY (promotion_id) REFERENCES promotion (promotion_id) ON DELETE CASCADE,
        FOREIGN KEY (food_id) REFERENCES foods (food_id) ON DELETE CASCADE
      );
    ''');
    await db.execute('''
      CREATE TABLE voucher (
        voucher_id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        required_point INTEGER NOT NULL,
        end_date DATE NOT NULL,
        image TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE user_voucher (
        user_id INTEGER NOT NULL,
        voucher_id INTEGER NOT NULL,
        redeemed_date DATE DEFAULT CURRENT_DATE,
        PRIMARY KEY (user_id, voucher_id),
        FOREIGN KEY (user_id) REFERENCES user (user_id) ON DELETE CASCADE,
        FOREIGN KEY (voucher_id) REFERENCES voucher (voucher_id) ON DELETE CASCADE
      );
    ''');
  }
}
