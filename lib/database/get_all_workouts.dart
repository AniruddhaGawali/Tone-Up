import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<List> getWorkouts() async {
  Completer<List<dynamic>> completer = Completer<List<dynamic>>();
  List<dynamic> workoutsList = []; // Declare the variable outside

  Stream<QuerySnapshot> snapshot =
      FirebaseFirestore.instance.collection('exercise').snapshots();

  snapshot.listen((QuerySnapshot querySnapshot) {
    workoutsList = querySnapshot.docs
        .map((QueryDocumentSnapshot doc) => doc.data())
        .toList();

    completer.complete(workoutsList);
  });

  await completer.future;

  return workoutsList;
}
