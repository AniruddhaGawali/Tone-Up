import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:toneup/model/workouts.dart';

import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class UserExerciseNotifier extends StateNotifier<List<Exercise>> {
  UserExerciseNotifier() : super([]);

  void addAllWorkouts(List<dynamic> workouts) {
    state = workouts.map((workout) => Exercise.fromJson(workout)).toList();
  }

  List<Exercise> getExercise() {
    _loadExercises();
    return state;
  }

  List<Exercise> getWorkouts() {
    _loadExercises();
    return state.where((element) => !element.isWarmUp).toList();
  }

  List<Exercise> getWarmUp() {
    _loadExercises();
    return state.where((element) => element.isWarmUp).toList();
  }

  Future<Database> _getDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, 'toneup.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE exercises(name TEXT PRIMARY KEY, cal_burn REAL ,time REAL , is_warmup INTEGER)',
        );
      },
      version: 1,
    );

    return db;
  }

  Future saveExercises(List<Exercise> exercises) async {
    final db = await _getDatabase();

    for (var exercise in exercises) {
      await db.insert(
        'exercises',
        {
          'name': exercise.name,
          'cal_burn': exercise.calBurn,
          'time': exercise.time,
          'is_warmup': exercise.isWarmUp ? 1 : 0,
        },
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
    }
  }

  Future<bool> _loadExercises() async {
    final db = await _getDatabase();
    final data = await db.query('exercises');

    if (data.isNotEmpty) {
      state = data.map((e) => Exercise.fromMap(e)).toList();
      return true;
    } else {
      return false;
    }
  }

  Future<void> deleteExercises() async {
    final db = await _getDatabase();
    db.delete('exercises');
  }

  bool isExerciseExist() {
    _loadExercises();
    print(state);

    return state.isNotEmpty;
  }
}

final userExerciseProvider =
    StateNotifierProvider<UserExerciseNotifier, List<Exercise>>(
  (ref) => UserExerciseNotifier(),
);
