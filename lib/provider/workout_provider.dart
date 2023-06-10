import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toneup/model/workouts.dart';

class WorkoutNotifier extends StateNotifier<List<Workout>> {
  WorkoutNotifier() : super([]);

  void addAllWorkouts(List<dynamic> workouts) {
    state = workouts.map((workout) => Workout.fromJson(workout)).toList();
  }

  List<Workout> getWorkouts() {
    return state;
  }
}

final workoutProvider = StateNotifierProvider<WorkoutNotifier, List<Workout>>(
  (ref) => WorkoutNotifier(),
);
