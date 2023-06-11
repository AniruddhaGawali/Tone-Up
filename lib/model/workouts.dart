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
    return name
        .split(' ')
        .map((e) => e[0].toUpperCase() + e.substring(1))
        .join(' ');
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
        name: json['name'].toString(),
        calBurn: double.parse(json['cal_burn'].toString()),
        time: double.parse(json['time'].toString()),
        isWarmUp: json['is_warmup']);
  }
}
