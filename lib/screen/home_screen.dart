import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toneup/provider/user_workout_provider.dart';
import 'package:toneup/screen/set_workout_screen.dart';
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
          // leading: Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          //   child: Text(
          //     "ToneUp 💪",
          //     style: TextStyle(
          //       fontSize: 20,
          //       fontWeight: FontWeight.bold,
          //       color: Theme.of(context).colorScheme.onBackground,
          //     ),
          //   ),
          // ),
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
                      ref.read(userExerciseProvider.notifier).isExerciseExist()
                          ? SizedBox()
                          : const OwnWorkoutButton()
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

class OwnWorkoutButton extends StatelessWidget {
  const OwnWorkoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
              "Design Your Own Workout",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground,
                letterSpacing: 1,
              ),
            ),
          ),
          const Positioned(
            top: 5,
            right: 5,
            child: Icon(
              size: 35,
              Icons.add_circle,
            ),
          ),
        ],
      ),
    );
  }
}
