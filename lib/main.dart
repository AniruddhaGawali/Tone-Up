import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toneup/database/get_all_workouts.dart';
import 'package:toneup/screen/home_screen.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:toneup/provider/workout_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({Key? key}) : super(key: key);

  final _theme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Open Sans',
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color(0xFF003742),
      background: Colors.black,
      onBackground: Colors.white,
    ),
  );

  void setWorkouts(WidgetRef ref) async {
    final workouts = await getWorkouts();
    ref.read(workoutProvider.notifier).addAllWorkouts(workouts);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    setWorkouts(ref);
    return MaterialApp(
      theme: _theme,
      home: const HomeScreen(),
    );
  }
}
