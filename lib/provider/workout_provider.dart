import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toneup/model/workouts.dart';

class WorkoutNotifier extends StateNotifier<List<Exercise>> {
  WorkoutNotifier() : super([]);

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

final workoutProvider = StateNotifierProvider<WorkoutNotifier, List<Exercise>>(
  (ref) => WorkoutNotifier(),
);
