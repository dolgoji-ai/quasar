import 'package:quasar/enums/event_status.dart';
import 'package:quasar/models/member.dart';

class Event {
  final String id;
  final EventStatus status;
  final String title;
  final String host;
  final String imageUrl;
  final DateTime eventDate;
  final String location;
  final String locationDetails;
  final List<Member> memberList;

  Event({
    required this.id,
    required this.status,
    required this.title,
    required this.host,
    required this.imageUrl,
    required this.eventDate,
    required this.location,
    required this.locationDetails,
    required this.memberList,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status.name,
      'title': title,
      'host': host,
      'imageUrl': imageUrl,
      'eventDate': eventDate.toIso8601String(),
      'location': location,
      'locationDetails': locationDetails,
      'memberList': memberList.map((member) => member.toJson()).toList(),
    };
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as String,
      status: EventStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => EventStatus.scheduled,
      ),
      title: json['title'] as String,
      host: json['host'] as String,
      imageUrl: json['imageUrl'] as String,
      eventDate: DateTime.parse(json['eventDate'] as String),
      location: json['location'] as String,
      locationDetails: json['locationDetails'] as String,
      memberList: (json['memberList'] as List<dynamic>)
          .map(
            (memberJson) => Member.fromJson(memberJson as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
