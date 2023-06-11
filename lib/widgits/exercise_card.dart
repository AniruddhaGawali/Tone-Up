import 'package:flutter/material.dart';
import 'package:toneup/model/workouts.dart';
import 'package:awesome_number_picker/awesome_number_picker.dart';
import 'package:toneup/screen/exercise_screen.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final bool isWarmUp;
  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.isWarmUp,
  });

  void selectExercise(BuildContext context) {
    int totalSet = 1;

    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 550,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onBackground,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 5,
                  width: 50,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  exercise.getName,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Total Sets",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: IntegerNumberPicker(
                    initialValue: 1,
                    size: 80,
                    minValue: 0,
                    maxValue: 21,
                    otherItemsDecoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    pickedItemDecoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSurface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onChanged: (i) {
                      totalSet = i;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    if (totalSet == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              const Text("Please select greater than 0 Set"),
                          backgroundColor:
                              Theme.of(context).colorScheme.onSurface,
                        ),
                      );
                      Navigator.pop(context);
                      return;
                    }
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ExercsieScreeen(
                                  exercise: exercise,
                                  totalSet: totalSet,
                                )));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: Icon(
                    Icons.play_arrow,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: 20,
                  ),
                  label: Text(
                    "Start",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      color: Theme.of(context).colorScheme.onSurface,
      child: ListTile(
        onTap: () => selectExercise(context),
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
