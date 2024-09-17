class Task {
  String title;
  String description;
  bool isCompleted;
  DateTime deadline;
  DateTime? startTime;
  DateTime? endTime;

  Task({
    required this.title,
    required this.description,
    required this.deadline,
    this.isCompleted = false,
    this.startTime,
    this.endTime,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      description: json['description'],
      deadline: DateTime.parse(json['deadline']),
      isCompleted: json['isCompleted'],
      startTime:
          json['startTime'] != null ? DateTime.parse(json['startTime']) : null,
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'deadline': deadline.toIso8601String(),
      'isCompleted': isCompleted,
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
    };
  }

  void startTask() {
    startTime = DateTime.now();
  }

  void completeTask() {
    isCompleted = true;
    endTime = DateTime.now();
  }
}
