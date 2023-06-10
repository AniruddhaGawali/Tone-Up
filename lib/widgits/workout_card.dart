import 'package:flutter/material.dart';

class WorkoutCard extends StatelessWidget {
  final String title;
  final String image;

  const WorkoutCard({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        children: [
          Container(
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
