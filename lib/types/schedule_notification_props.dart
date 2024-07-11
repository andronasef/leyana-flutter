class ScheduleNotificationProps {
  String title;

  int id;

  String body;

  DateTime scheduledDate;

  ScheduleNotificationProps(
      {required this.id,
      required this.title,
      required this.body,
      required this.scheduledDate});
}
