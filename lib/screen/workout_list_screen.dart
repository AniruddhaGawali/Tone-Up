import 'package:flutter/material.dart';
import 'package:toneup/widgits/exercise_card.dart';

class ExerciseListScreen extends StatelessWidget {
  final String title;
  final String image;
  final List<dynamic> exerciseList;
  const ExerciseListScreen({
    Key? key,
    required this.title,
    required this.image,
    required this.exerciseList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onBackground,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: ListView.builder(
                        itemCount: exerciseList.length,
                        itemBuilder: (bctx, index) => ExerciseCard(
                          exercise: exerciseList[index],
                          isWarmUp: title == "Workout" ? false : true,
                        ),
                      ),
                    ));
              },
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }
}
