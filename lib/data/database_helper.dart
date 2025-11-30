import 'dart:async';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_live/sqflite_live.dart';

class DatabaseHelper {
  // SINGLETON
  DatabaseHelper._internal();
  static final DatabaseHelper instance = DatabaseHelper._internal();

  static const String _dbName = 'manual_sistema_web.db';
  static const int _dbVersion = 1;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    final db = await openDatabase(
      path,
      version: _dbVersion,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onOpen: (db) async {
        await _ensureTables(db);
      },
    );

    // SQFLITE LIVE – SOLO DESARROLLO
    if (!kReleaseMode) {
      try {
        await db.live(port: 8888);
        print('✅ SQFLITE LIVE → http://localhost:8888');
        print('💡 adb reverse tcp:8888 tcp:8888');
      } catch (e) {
        print('⚠️ No se pudo iniciar sqflite_live: $e');
      }
    }

    return db;
  }

  // ==========================================
  // CREACIÓN INICIAL
  // ==========================================
  Future<void> _onCreate(Database db, int version) async {
    await _runDDL(db);
    await _seedAdmin(db); // ⬅️ SEEDER AÑADIDO
  }

  // ==========================================
  // MIGRACIONES FUTURAS
  // ==========================================
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {}

  // ==========================================
  // REFUERZO
  // ==========================================
  Future<void> _ensureTables(Database db) async {
    await _runDDL(db);
  }

  // ==========================================
  // SEEDER ADMIN DEMO
  // ==========================================
  Future<void> _seedAdmin(Database db) async {
    final result = await db.rawQuery("SELECT COUNT(*) as total FROM usuario");
    final count = (result.first["total"] as int?) ?? 0;

    if (count == 0) {
      final now = DateTime.now().toIso8601String();

      await db.insert("usuario", {
        "nombre_usuario": "admin",
        "nombres": "Juan Pablo",
        "ap_paterno": "Ramirez",
        "ap_materno": "Aguilar",
        "correo": "admin@gmail.com",
        "contrasena": "1234",
        "estado": "ACTIVO",
        "avatar_ruta": null,
        "fecha_creacion": now,
        "fecha_actualizacion": now,
      });

      print("✅ Seeder: ADMIN creado correctamente.");
    }
  }

  // ==========================================
  // ESTRUCTURA DE TABLAS
  // ==========================================
  Future<void> _runDDL(Database db) async {
    // 1. TABLA USUARIO
    await db.execute('''
      CREATE TABLE IF NOT EXISTS usuario (
        id                  INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre_usuario      TEXT NOT NULL UNIQUE,
        nombres             TEXT NOT NULL,
        ap_paterno          TEXT,
        ap_materno          TEXT,
        correo              TEXT NOT NULL UNIQUE,
        contrasena          TEXT NOT NULL,
        estado              TEXT NOT NULL DEFAULT 'ACTIVO',
        avatar_ruta         TEXT,
        fecha_creacion      TEXT NOT NULL,
        fecha_actualizacion TEXT NOT NULL
      );
    ''');

    // 2. TABLA PROGRESO USUARIO
    await db.execute('''
      CREATE TABLE IF NOT EXISTS progreso_usuario (
        id          INTEGER PRIMARY KEY AUTOINCREMENT,
        usuario_id  INTEGER NOT NULL,
        paso_id     INTEGER NOT NULL,
        completado  INTEGER NOT NULL DEFAULT 0,
        fecha       TEXT NOT NULL,
        FOREIGN KEY (usuario_id)
          REFERENCES usuario (id)
          ON DELETE CASCADE,
        UNIQUE (usuario_id, paso_id)
      );
    ''');

    // 3. TABLA FAVORITO
    await db.execute('''
      CREATE TABLE IF NOT EXISTS favorito (
        id          INTEGER PRIMARY KEY AUTOINCREMENT,
        usuario_id  INTEGER NOT NULL,
        paso_id     INTEGER NOT NULL,
        fecha       TEXT NOT NULL,
        FOREIGN KEY (usuario_id)
          REFERENCES usuario (id)
          ON DELETE CASCADE,
        UNIQUE (usuario_id, paso_id)
      );
    ''');
  }

  // ==========================================
  // CIERRE
  // ==========================================
  Future<void> close() async {
    final db = _database;
    if (db != null && db.isOpen) {
      await db.close();
      _database = null;
    }
  }

  // ==========================================
  // CRUD BAJO NIVEL
  // ==========================================
  Future<List<Map<String, Object?>>> rawQuery(
    String sql, [
    List<Object?>? args,
  ]) async {
    final db = await database;
    return db.rawQuery(sql, args);
  }

  Future<int> rawInsert(
    String sql, [
    List<Object?>? args,
  ]) async {
    final db = await database;
    return db.rawInsert(sql, args);
  }

  Future<int> rawUpdate(
    String sql, [
    List<Object?>? args,
  ]) async {
    final db = await database;
    return db.rawUpdate(sql, args);
  }

  Future<int> rawDelete(
    String sql, [
    List<Object?>? args,
  ]) async {
    final db = await database;
    return db.rawDelete(sql, args);
  }

  // ==========================================
  // 🔄 RESET (SOLO DESARROLLO)
  // ==========================================
  static Future<void> resetDevDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    await deleteDatabase(path);
    _database = null;
    await instance.database;
  }
}
