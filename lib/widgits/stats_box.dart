import 'package:flutter/material.dart';

class StatsBox extends StatelessWidget {
  const StatsBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 20,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Spacer(),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "Total Cals \nBurned",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.background,
                height: .9,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "1.000",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.background,
                height: 1,
              ),
            )
          ]),
          const Spacer(),
          const VerticalDivider(),
          const Spacer(),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "To Do's",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.background,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "50%",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.background,
                height: 1,
              ),
            )
          ]),
          const Spacer(),
          const VerticalDivider(),
          const Spacer(),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "Weight",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.background,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "85",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.background,
                    height: 1,
                  ),
                ),
                Text(
                  "kg",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.background,
                  ),
                )
              ],
            )
          ]),
          const Spacer(),
        ]),
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
          height: 70,
          color: Theme.of(context).colorScheme.background,
        ),
      ],
    );
  }
}
