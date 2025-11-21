import '../enums/event_status.dart';
import '../models/event.dart';

class EventRepository {
  static final EventRepository _instance = EventRepository._internal();

  factory EventRepository() => _instance;

  EventRepository._internal();

  final List<Event> _events = [
    Event(
      id: '10',
      status: EventStatus.scheduled,
      title: '연말 송년회',
      host: '임하은',
      imageUrl: 'https://picsum.photos/200/200?random=8',
      eventDate: DateTime(2025, 12, 28, 19, 0),
      memberList: [
        Member(name: '임하은', phoneNumber: '010-1234-5678'),
        Member(name: '김철수', phoneNumber: '010-2345-6789'),
        Member(name: '이영희', phoneNumber: '010-3456-7890'),
      ],
    ),
    Event(
      id: '9',
      status: EventStatus.scheduled,
      title: '팀 빌딩 워크샵',
      host: 'dolgoji-ai',
      imageUrl: 'https://picsum.photos/200/200?random=2',
      eventDate: DateTime(2025, 11, 19, 18, 0),
      memberList: [
        Member(name: 'dolgoji-ai', phoneNumber: '010-4567-8901'),
        Member(name: '박지성', phoneNumber: '010-5678-9012'),
      ],
    ),
    Event(
      id: '8',
      status: EventStatus.scheduled,
      title: '여름 야유회',
      host: '최동욱',
      imageUrl: 'https://picsum.photos/200/200?random=5',
      eventDate: DateTime(2025, 11, 16, 14, 0),
      memberList: [
        Member(name: '최동욱', phoneNumber: '010-6789-0123'),
        Member(name: '정수아', phoneNumber: '010-7890-1234'),
        Member(name: '강민준', phoneNumber: '010-8901-2345'),
        Member(name: '송하율', phoneNumber: '010-9012-3456'),
      ],
    ),
    Event(
      id: '7',
      status: EventStatus.completed,
      title: '부서 워크샵',
      host: '한유진',
      imageUrl: 'https://picsum.photos/200/200?random=10',
      eventDate: DateTime(2025, 6, 20, 9, 0),
      memberList: [
        Member(name: '한유진', phoneNumber: '010-0123-4567'),
        Member(name: '오세훈', phoneNumber: '010-1235-6789'),
        Member(name: '윤서연', phoneNumber: '010-2346-7890'),
        Member(name: '장민재', phoneNumber: '010-3457-8901'),
        Member(name: '배수진', phoneNumber: '010-4568-9012'),
      ],
    ),
    Event(
      id: '6',
      status: EventStatus.completed,
      title: '신입사원 환영회',
      host: '윤지훈',
      imageUrl: 'https://picsum.photos/200/200?random=7',
      eventDate: DateTime(2025, 5, 5, 18, 30),
      memberList: [Member(name: '윤지훈', phoneNumber: '010-5679-0123')],
    ),
    Event(
      id: '5',
      status: EventStatus.completed,
      title: '프로젝트 킥오프 미팅',
      host: 'dolgoji-ai',
      imageUrl: 'https://picsum.photos/200/200?random=4',
      eventDate: DateTime(2025, 3, 10, 10, 0),
      memberList: [
        Member(name: 'dolgoji-ai', phoneNumber: '010-6780-1234'),
        Member(name: '이서준', phoneNumber: '010-7891-2345'),
        Member(name: '최예린', phoneNumber: '010-8902-3456'),
      ],
    ),
    Event(
      id: '4',
      status: EventStatus.completed,
      title: '2025 신년회',
      host: '김철수',
      imageUrl: 'https://picsum.photos/200/200?random=1',
      eventDate: DateTime(2025, 1, 15, 18, 0),
      memberList: [
        Member(name: '김철수', phoneNumber: '010-9013-4567'),
        Member(name: '박민수', phoneNumber: '010-0124-5678'),
        Member(name: '안혜진', phoneNumber: '010-1236-7890'),
        Member(name: '신동현', phoneNumber: '010-2347-8901'),
      ],
    ),
    Event(
      id: '3',
      status: EventStatus.completed,
      title: '분기별 회식',
      host: '이민호',
      imageUrl: 'https://picsum.photos/200/200?random=3',
      eventDate: DateTime(2024, 12, 20, 19, 30),
      memberList: [
        Member(name: '이민호', phoneNumber: '010-3458-9012'),
        Member(name: '권나영', phoneNumber: '010-4569-0123'),
      ],
    ),
    Event(
      id: '2',
      status: EventStatus.completed,
      title: '월간 회고 모임',
      host: 'dolgoji-ai',
      imageUrl: 'https://picsum.photos/200/200?random=6',
      eventDate: DateTime(2024, 11, 30, 15, 30),
      memberList: [
        Member(name: 'dolgoji-ai', phoneNumber: '010-5670-1234'),
        Member(name: '조윤아', phoneNumber: '010-6781-2345'),
        Member(name: '유재석', phoneNumber: '010-7892-3456'),
        Member(name: '강호동', phoneNumber: '010-8903-4567'),
        Member(name: '이효리', phoneNumber: '010-9014-5678'),
      ],
    ),
    Event(
      id: '1',
      status: EventStatus.completed,
      title: '스터디 그룹 정기모임',
      host: '서준호',
      imageUrl: 'https://picsum.photos/200/200?random=9',
      eventDate: DateTime(2024, 10, 15, 20, 0),
      memberList: [
        Member(name: '서준호', phoneNumber: '010-0125-6789'),
        Member(name: '노지훈', phoneNumber: '010-1237-8901'),
        Member(name: '임소영', phoneNumber: '010-2348-9012'),
      ],
    ),
  ];

  Future<List<Event>> getEvents({
    bool upcomingOnly = false,
    String? hostFilter,
  }) async {
    var filtered = List<Event>.from(_events);

    if (upcomingOnly) {
      final now = DateTime.now();
      final oneWeekLater = now.add(const Duration(days: 7));
      filtered = filtered.where((event) {
        return event.eventDate.isAfter(now) &&
            event.eventDate.isBefore(oneWeekLater);
      }).toList();
    }

    if (hostFilter != null) {
      filtered = filtered.where((event) {
        return event.host == hostFilter;
      }).toList();
    }

    return filtered;
  }

  Future<Event?> getEventById(String id) async {
    try {
      return _events.firstWhere((event) => event.id == id);
    } catch (e) {
      return null;
    }
  }
}
