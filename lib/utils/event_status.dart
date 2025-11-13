enum EventStatus {
  inProgress('진행중'),
  scheduled('예정'),
  completed('완료');

  final String displayName;

  const EventStatus(this.displayName);

  static EventStatus fromString(String value) {
    return EventStatus.values.firstWhere(
      (status) => status.displayName == value,
      orElse: () => EventStatus.completed,
    );
  }
}
