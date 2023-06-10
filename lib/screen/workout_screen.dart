import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toneup/provider/workout_provider.dart';

class WorkoutScreen extends ConsumerWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(ref.read(workoutProvider.notifier).getWorkouts());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout'),
      ),
      body: const Center(
        child: Text('Workout'),
      ),
    );
  }
}
