import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toneup/provider/user_workout_provider.dart';
import 'package:toneup/screen/exercise_screen.dart';
import 'package:toneup/screen/exercise_list_screen.dart';

class UserWorkoutScreeen extends ExerciseListScreen {
  final WidgetRef ref;
  final BuildContext context;

  UserWorkoutScreeen({super.key, required this.ref, required this.context})
      : super(
            title: "User Workout",
            image: "assets/images/own_workout.jpg",
            exerciseList: ref
                .read(userExerciseProvider.notifier)
                .getExercise()
                .map((e) => e.keys.first)
                .toList(),
            sets: ref
                .read(userExerciseProvider.notifier)
                .getExercise()
                .map((e) => e.values.first)
                .toList(),
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: FloatingActionButton.extended(
                    heroTag: "btn1",
                    onPressed: () async {
                      for (var exercise in ref
                          .read(userExerciseProvider.notifier)
                          .getExercise()) {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExercsieScreeen(
                                  exercise: exercise.keys.first,
                                  totalSet: exercise.values.first)),
                        );
                      }
                    },
                    label: const Text(
                      "Start Workout",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    icon: const Icon(
                      Icons.play_arrow,
                      size: 25,
                    ),
                  ),
                ),
                Row(
                  children: [
                    FloatingActionButton(
                      heroTag: "btn2",
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Feature Under Development",
                            ),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.edit,
                        size: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    FloatingActionButton(
                      heroTag: "btn3",
                      onPressed: () {
                        ref
                            .read(userExerciseProvider.notifier)
                            .deleteExercises();
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.delete,
                        size: 25,
                      ),
                    ),
                  ],
                )
              ],
            ));
}
