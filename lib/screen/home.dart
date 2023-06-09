import 'package:flutter/material.dart';
import 'package:toneup/widgits/stats_box.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: CustomScrollView(slivers: [
        SliverAppBar.medium(
          leading: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Text(
              "ToneUp 💪",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
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
              height: 1000,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onBackground,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Center(
                child: Text('Fill'),
              ),
            );
          },
          childCount: 1,
        ))
      ]),
    );
  }
}
