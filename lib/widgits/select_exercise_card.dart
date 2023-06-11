import 'package:flutter/material.dart';
import 'package:toneup/widgits/exercise_card.dart';

class SelectExerciseCard extends ExerciseCard {
  final int pageIndex;

  const SelectExerciseCard({
    required super.key,
    required super.exercise,
    required super.onSelect,
    required super.isSelected,
    super.sets,
    required this.pageIndex,
  }) : super(
          icon: pageIndex == 2 ? Icons.remove : Icons.add,
        );
}
