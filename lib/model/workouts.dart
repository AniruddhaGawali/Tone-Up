class Exercise {
  String name;
  double calBurn;
  double time;
  bool isWarmUp;

  Exercise({
    required this.name,
    required this.calBurn,
    required this.time,
    required this.isWarmUp,
  });

  String get getName {
    return name[0].toUpperCase() + name.substring(1).toLowerCase();
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
        name: json['name'],
        calBurn: json['cal_burn'],
        time: json['time'],
        isWarmUp: json['is_warmup']);
  }
}
