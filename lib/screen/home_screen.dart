import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toneup/provider/user_workout_provider.dart';
import 'package:toneup/screen/set_workout_screen.dart';
import 'package:toneup/screen/user_workout_screen.dart';
import 'package:toneup/widgits/stats_box.dart';
import 'package:toneup/widgits/categories_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: CustomScrollView(slivers: [
        SliverAppBar.medium(
          leadingWidth: double.infinity,
          backgroundColor: Theme.of(context).colorScheme.background,
          expandedHeight: 300,
          flexibleSpace: FlexibleSpaceBar(
            background: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          height: .9,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      Text(
                        "Welcome Back to ToneUp",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const StatsBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Container(
              height: MediaQuery.of(context).size.height -
                  (300 + MediaQuery.of(context).padding.top),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onBackground,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Let's Start!",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.background,
                          )),
                      Text("Select Your Workout",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.background,
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          CategoriesCard(
                            title: "Warm Up",
                            image: "assets/images/warmup.jpg",
                          ),
                          CategoriesCard(
                            title: "Workout",
                            image: "assets/images/workout.jpg",
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      FutureBuilder(
                        future: ref
                            .read(userExerciseProvider.notifier)
                            .isExerciseExist(),
                        builder: (BuildContext bctx, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text("Something went wrong"),
                            );
                          }
                          if (snapshot.data == false) {
                            return const UserWorkoutButton(
                                title: "Design Your Own Workout");
                          }
                          print(ref
                              .read(userExerciseProvider.notifier)
                              .getExercise());
                          return const UserWorkoutButton(title: "Your Workout");
                        },
                      ),
                    ]),
              ),
            );
          },
          childCount: 1,
        ))
      ]),
    );
  }
}

class UserWorkoutButton extends ConsumerWidget {
  final String title;
  const UserWorkoutButton({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        if (title == "Your Workout") {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => UserWorkoutScreeen(
                    context: _,
                    ref: ref,
                  )));
          return;
        }
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const SetWorkoutScreen()));
      },
      child: Stack(
        children: [
          Hero(
            tag: "own_workout",
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  image: AssetImage("assets/images/own_workout.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 160,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF003742).withOpacity(.9),
                  const Color(0xFF003742).withOpacity(0),
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 15,
            width: MediaQuery.of(context).size.width / 1.5,
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
          title != "Your Workout"
              ? const Positioned(
                  top: 5,
                  right: 5,
                  child: Icon(
                    size: 35,
                    Icons.add_circle,
                  ),
                )
              : const Positioned(
                  top: 5,
                  right: 5,
                  child: Icon(
                    size: 35,
                    Icons.play_arrow_rounded,
                  ),
                ),
        ],
      ),
    );
  }
}
