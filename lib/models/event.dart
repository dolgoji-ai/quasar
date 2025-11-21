import '../enums/event_status.dart';

class Member {
  final String name;
  final String phoneNumber;

  Member({required this.name, required this.phoneNumber});
}

class Event {
  final String id;
  final EventStatus status;
  final String title;
  final String host;
  final String imageUrl;
  final DateTime eventDate;
  final List<Member> memberList;

  Event({
    required this.id,
    required this.status,
    required this.title,
    required this.host,
    required this.imageUrl,
    required this.eventDate,
    required this.memberList,
  });
}
