import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toneup/model/workouts.dart';
import 'package:toneup/provider/user_workout_provider.dart';
import 'package:toneup/provider/workout_provider.dart';
import 'package:toneup/widgits/select_exercise_card.dart';

class SetWorkoutScreen extends ConsumerStatefulWidget {
  const SetWorkoutScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<SetWorkoutScreen> createState() => _SetWorkoutScreenState();
}

class _SetWorkoutScreenState extends ConsumerState<SetWorkoutScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabBarContoller;

  int pageIndex = 0;
  List<Exercise> selectedExercise = [];

  @override
  void initState() {
    tabBarContoller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabBarContoller.dispose();
    super.dispose();
  }

  List<Exercise> get exerciseList {
    if (pageIndex == 0) {
      return ref.read(exerciseProvider.notifier).getWarmUp();
    } else if (pageIndex == 1) {
      return ref.read(exerciseProvider.notifier).getWorkouts();
    } else {
      return selectedExercise;
    }
  }

  String get title {
    if (pageIndex == 0) {
      return "Select Warm Up";
    } else if (pageIndex == 1) {
      return "Select Workouts";
    } else {
      return "Final List";
    }
  }

  void addToSelectedExercise(Exercise exercise) {
    List<Exercise> temp = [...selectedExercise];
    if (selectedExercise.contains(exercise)) {
      temp = temp.where((element) => element != exercise).toList();
      setState(() {
        selectedExercise = temp;
      });
      selectedExercise.remove(exercise);
    } else {
      temp.add(exercise);
      setState(() {
        selectedExercise = temp;
      });
    }
  }

  void saveExerciseInDatebase() async {
    await ref
        .read(userExerciseProvider.notifier)
        .saveExercises(selectedExercise);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.onBackground,
        child: CustomScrollView(
          slivers: [
            SliverAppBar.medium(
              backgroundColor: const Color(0xFF003742),
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Hero(
                      tag: "own_workout",
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/own_workout.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF003742).withOpacity(1),
                            const Color(0xFF003742).withOpacity(0),
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                      ),
                    ),
                  ],
                ),
                title: Text(
                  title,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => SelectExerciseCard(
                  key: Key(index.toString()),
                  exercise: exerciseList[index],
                  isWarmUp: exerciseList[index].isWarmUp,
                  onSelect: addToSelectedExercise,
                  isSelected: selectedExercise.contains(exerciseList[index]),
                  pageIndex: pageIndex,
                ),
                childCount: exerciseList.length,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width - 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton.extended(
              heroTag: "prev",
              disabledElevation: double.minPositive,
              onPressed: pageIndex == 0
                  ? null
                  : () {
                      setState(() {
                        if (pageIndex > 0) {
                          pageIndex--;
                        }
                      });
                    },
              icon: const Icon(Icons.arrow_back),
              label: const Text("Prev"),
            ),
            pageIndex != 2
                ? FloatingActionButton.extended(
                    heroTag: "next",
                    onPressed: pageIndex == 2
                        ? null
                        : () {
                            setState(() {
                              if (pageIndex < 2) {
                                pageIndex++;
                              }
                            });
                          },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text("Next"),
                  )
                : FloatingActionButton.extended(
                    heroTag: "done",
                    onPressed: pageIndex != 2
                        ? null
                        : () {
                            saveExerciseInDatebase();
                          },
                    icon: const Icon(Icons.done),
                    label: const Text("Final"),
                  )
          ],
        ),
      ),
    );
  }
}
