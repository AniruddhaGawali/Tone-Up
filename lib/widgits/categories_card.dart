import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toneup/model/workouts.dart';
import 'package:toneup/provider/workout_provider.dart';
import 'package:toneup/screen/workout_list_screen.dart';

class CategoriesCard extends ConsumerWidget {
  final String title;
  final String image;

  const CategoriesCard({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ExerciseListScreen(
                  title: title,
                  image: image,
                  exerciseList: title == 'Warm Up'
                      ? ref.watch(workoutProvider.notifier).getWarmUp()
                      : ref.watch(workoutProvider.notifier).getWorkouts(),
                )));
      },
      child: Stack(
        children: [
          Hero(
            tag: title + image,
            child: Container(
              width: 155,
              height: 155,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            width: 155,
            height: 155,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF003742).withOpacity(.8),
                  const Color(0xFF003742).withOpacity(0),
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 15,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
