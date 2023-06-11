import 'package:flutter/material.dart';
import 'package:toneup/model/workouts.dart';
import 'package:toneup/widgits/exercise_card.dart';

class ExerciseListScreen extends StatelessWidget {
  final String title;
  final String image;
  final List<Exercise> exerciseList;
  final List<int>? sets;
  final Widget? floatingActionButton;
  const ExerciseListScreen({
    Key? key,
    required this.title,
    required this.image,
    required this.exerciseList,
    this.floatingActionButton,
    this.sets,
  }) : super(key: key);

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
                      tag: title + image,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(image),
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
            sets != null
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => ExerciseCard(
                        exercise: exerciseList[index],
                        sets: sets![index],
                      ),
                      childCount: exerciseList.length,
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => ExerciseCard(
                        exercise: exerciseList[index],
                      ),
                      childCount: exerciseList.length,
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
