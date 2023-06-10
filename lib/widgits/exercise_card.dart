import 'package:flutter/material.dart';
import 'package:toneup/model/workouts.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final bool isWarmUp;
  const ExerciseCard(
      {super.key, required this.exercise, required this.isWarmUp});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondary,
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(
            isWarmUp ? Icons.directions_run : Icons.fitness_center,
            color: Theme.of(context).colorScheme.onBackground,
            size: 30,
          ),
        ),
        title: Text(exercise.getName,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        subtitle: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Icon(Icons.local_fire_department,
              color: Theme.of(context).colorScheme.onPrimary, size: 15),
          Text(
            " : ${exercise.calBurn.toString()} cal",
            style: TextStyle(
              color: Theme.of(context).colorScheme.background,
              fontSize: 13,
            ),
          ),
          const VerticalDivider(),
          Icon(Icons.timer,
              color: Theme.of(context).colorScheme.onPrimary, size: 15),
          Text(
            " : ${exercise.time.toString()} min",
            style: TextStyle(
              color: Theme.of(context).colorScheme.background,
              fontSize: 13,
            ),
          ),
        ]),
        trailing: Icon(
          Icons.play_arrow,
          color: Theme.of(context).colorScheme.onPrimary,
          size: 30,
        ),
      ),
    );
  }
}

class VerticalDivider extends StatelessWidget {
  const VerticalDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 1,
          height: 15,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          color: Theme.of(context).colorScheme.background,
        ),
      ],
    );
  }
}
