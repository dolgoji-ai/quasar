import '../utils/event_status.dart';

class Event {
  final String id;
  final EventStatus status;
  final String title;
  final String host;
  final String imageUrl;
  final DateTime eventDate;

  Event({
    required this.id,
    required this.status,
    required this.title,
    required this.host,
    required this.imageUrl,
    required this.eventDate,
  });
}
