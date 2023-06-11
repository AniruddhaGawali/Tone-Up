import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:toneup/model/workouts.dart';

import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class UserExerciseNotifier extends StateNotifier<List<Map<Exercise, int>>> {
  UserExerciseNotifier() : super([]);

  List<Map<Exercise, int>> getExercise() {
    return state;
  }

  List<Map<Exercise, int>> getWorkouts() {
    return state.where((element) => !element.keys.first.isWarmUp).toList();
  }

  List<Map<Exercise, int>> getWarmUp() {
    return state.where((element) => element.keys.first.isWarmUp).toList();
  }

  Future<Database> _getDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, 'toneup.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE exercises(name TEXT PRIMARY KEY, cal_burn REAL ,time REAL, is_warmup INTEGER, sets INTEGER)',
        );
      },
      version: 1,
    );

    return db;
  }

  Future saveExercises(List<Map<Exercise, int>> exercises) async {
    final db = await _getDatabase();

    for (var exercise in exercises) {
      await db.insert(
        'exercises',
        {
          'name': exercise.keys.first.name,
          'cal_burn': exercise.keys.first.calBurn,
          'time': exercise.keys.first.time,
          'is_warmup': exercise.keys.first.isWarmUp ? 1 : 0,
          'sets': exercise.values.first,
        },
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
    }
  }

  Future<bool> _loadExercises() async {
    final db = await _getDatabase();
    final data = await db.query('exercises');

    if (data.isNotEmpty) {
      state = data
          .map((e) => {Exercise.fromMap(e): int.parse(e['sets'].toString())})
          .toList();
      return true;
    } else {
      return false;
    }
  }

  Future<void> deleteExercises() async {
    final db = await _getDatabase();
    db.delete('exercises');
  }

  Future<bool> isExerciseExist() async {
    await _loadExercises();

    return state.isNotEmpty;
  }
}

final userExerciseProvider =
    StateNotifierProvider<UserExerciseNotifier, List<Map<Exercise, int>>>(
  (ref) => UserExerciseNotifier(),
);
