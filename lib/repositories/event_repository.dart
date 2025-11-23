import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quasar/models/event.dart';

class EventRepository {
  static final EventRepository _instance = EventRepository._internal();

  factory EventRepository() => _instance;

  EventRepository._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Event>> getEvents({
    String? hostFilter,
    DateTime? fromDateFilter,
    DateTime? toDateFilter,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _firestore.collection('events');

      if (hostFilter != null) {
        query = query.where('host', isEqualTo: hostFilter);
      }

      if (fromDateFilter != null) {
        query = query.where(
          'eventDate',
          isGreaterThanOrEqualTo: fromDateFilter.toIso8601String(),
        );
      }

      if (toDateFilter != null) {
        query = query.where(
          'eventDate',
          isLessThanOrEqualTo: toDateFilter.toIso8601String(),
        );
      }

      final snapshot = await query.orderBy('eventDate', descending: true).get();

      var events = snapshot.docs
          .map((doc) => Event.fromJson(doc.data()))
          .toList();

      return events;
    } catch (e) {
      throw Exception('Failed to get events: $e');
    }
  }

  Future<Event?> getEventById(String id) async {
    try {
      final doc = await _firestore.collection('events').doc(id).get();
      if (doc.exists && doc.data() != null) {
        return Event.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> createEvent(Event event) async {
    try {
      await _firestore.collection('events').doc(event.id).set(event.toJson());
    } catch (e) {
      throw Exception('Failed to create event: $e');
    }
  }
}
