import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toneup/model/workouts.dart';

class ExerciseNotifier extends StateNotifier<List<Exercise>> {
  ExerciseNotifier() : super([]);

  void addAllWorkouts(List<dynamic> workouts) {
    state = workouts.map((workout) => Exercise.fromJson(workout)).toList();
  }

  List<Exercise> getExercise() {
    return state;
  }

  List<Exercise> getWorkouts() {
    return state.where((element) => !element.isWarmUp).toList();
  }

  List<Exercise> getWarmUp() {
    return state.where((element) => element.isWarmUp).toList();
  }
}

final exerciseProvider =
    StateNotifierProvider<ExerciseNotifier, List<Exercise>>(
  (ref) => ExerciseNotifier(),
);
