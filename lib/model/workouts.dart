class Workout {
  String name;
  double calBurn;
  double time;

  Workout({
    required this.name,
    required this.calBurn,
    required this.time,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      name: json['name'],
      calBurn: json['cal_burn'],
      time: json['time'],
    );
  }
}
