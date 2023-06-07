class Task {
  final String id;
  final String title;
  final String date;
  final String startTime;
  final String endTime;
  final String repeat;
  final int isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.repeat,
    required this.isCompleted,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      date: json['date'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      repeat: json['repeat'],
      isCompleted: json['isCompleted'],
    );
  }
}