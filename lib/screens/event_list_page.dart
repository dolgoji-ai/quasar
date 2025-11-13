import 'package:flutter/cupertino.dart';
import '../models/event.dart';
import '../utils/color_utils.dart';
import '../utils/event_status.dart';
import 'event_detail_page.dart';

class EventListPage extends StatefulWidget {
  const EventListPage({super.key});

  @override
  State<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  List<Event> events = [];

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  void _loadEvents() {
    events = [
      Event(
        id: '1',
        status: EventStatus.inProgress,
        title: '2025 신년회',
        host: '김철수',
        imageUrl: 'https://picsum.photos/200/200?random=1',
      ),
      Event(
        id: '2',
        status: EventStatus.scheduled,
        title: '팀 빌딩 워크샵',
        host: '박영희',
        imageUrl: 'https://picsum.photos/200/200?random=2',
      ),
      Event(
        id: '3',
        status: EventStatus.completed,
        title: '분기별 회식',
        host: '이민호',
        imageUrl: 'https://picsum.photos/200/200?random=3',
      ),
      Event(
        id: '4',
        status: EventStatus.inProgress,
        title: '프로젝트 킥오프 미팅',
        host: '정수진',
        imageUrl: 'https://picsum.photos/200/200?random=4',
      ),
      Event(
        id: '5',
        status: EventStatus.scheduled,
        title: '여름 야유회',
        host: '최동욱',
        imageUrl: 'https://picsum.photos/200/200?random=5',
      ),
      Event(
        id: '6',
        status: EventStatus.completed,
        title: '월간 회고 모임',
        host: '강민서',
        imageUrl: 'https://picsum.photos/200/200?random=6',
      ),
      Event(
        id: '7',
        status: EventStatus.inProgress,
        title: '신입사원 환영회',
        host: '윤지훈',
        imageUrl: 'https://picsum.photos/200/200?random=7',
      ),
      Event(
        id: '8',
        status: EventStatus.scheduled,
        title: '연말 송년회',
        host: '임하은',
        imageUrl: 'https://picsum.photos/200/200?random=8',
      ),
      Event(
        id: '9',
        status: EventStatus.completed,
        title: '스터디 그룹 정기모임',
        host: '서준호',
        imageUrl: 'https://picsum.photos/200/200?random=9',
      ),
      Event(
        id: '10',
        status: EventStatus.inProgress,
        title: '부서 워크샵',
        host: '한유진',
        imageUrl: 'https://picsum.photos/200/200?random=10',
      ),
    ];
  }

  void _navigateToDetail(Event event) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => EventDetailPage(event: event),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Quasar'),
      ),
      child: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return GestureDetector(
              onTap: () => _navigateToDetail(event),
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemGrey.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        event.imageUrl,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 80,
                            height: 80,
                            color: CupertinoColors.systemGrey5,
                            child: const Icon(
                              CupertinoIcons.photo,
                              color: CupertinoColors.systemGrey,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: getStatusColor(event.status),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              event.status.displayName,
                              style: const TextStyle(
                                color: CupertinoColors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            event.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: CupertinoColors.label,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.person_fill,
                                size: 16,
                                color: CupertinoColors.systemGrey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                event.host,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: CupertinoColors.systemGrey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
