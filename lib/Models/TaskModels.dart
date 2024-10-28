class Taskmodels {
  String? title;
  String? descriptions;
  String? date;
  String? time;

  Taskmodels({
    required this.title,
    required this.descriptions,
    required this.date,
    required this.time,
  });

  // Convert a Taskmodels instance to a Map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'descriptions': descriptions,
      'date': date,
      'time': time,
    };
  }

  // Convert a Map to a Taskmodels instance
  factory Taskmodels.fromJson(Map<String, dynamic> json) {
    return Taskmodels(
      title: json['title'],
      descriptions: json['descriptions'],
      date: json['date'],
      time: json['time'],
    );
  }
}
