import 'package:flutter/cupertino.dart';
import 'models/event.dart';
import 'pages/event_detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Quasar',
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.systemBlue,
      ),
      home: EventListPage(),
    );
  }
}

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
        status: '진행중',
        title: '2025 신년회',
        host: '김철수',
        imageUrl: 'https://picsum.photos/200/200?random=1',
      ),
      Event(
        id: '2',
        status: '예정',
        title: '팀 빌딩 워크샵',
        host: '박영희',
        imageUrl: 'https://picsum.photos/200/200?random=2',
      ),
      Event(
        id: '3',
        status: '완료',
        title: '분기별 회식',
        host: '이민호',
        imageUrl: 'https://picsum.photos/200/200?random=3',
      ),
      Event(
        id: '4',
        status: '진행중',
        title: '프로젝트 킥오프 미팅',
        host: '정수진',
        imageUrl: 'https://picsum.photos/200/200?random=4',
      ),
      Event(
        id: '5',
        status: '예정',
        title: '여름 야유회',
        host: '최동욱',
        imageUrl: 'https://picsum.photos/200/200?random=5',
      ),
      Event(
        id: '6',
        status: '완료',
        title: '월간 회고 모임',
        host: '강민서',
        imageUrl: 'https://picsum.photos/200/200?random=6',
      ),
      Event(
        id: '7',
        status: '진행중',
        title: '신입사원 환영회',
        host: '윤지훈',
        imageUrl: 'https://picsum.photos/200/200?random=7',
      ),
      Event(
        id: '8',
        status: '예정',
        title: '연말 송년회',
        host: '임하은',
        imageUrl: 'https://picsum.photos/200/200?random=8',
      ),
      Event(
        id: '9',
        status: '완료',
        title: '스터디 그룹 정기모임',
        host: '서준호',
        imageUrl: 'https://picsum.photos/200/200?random=9',
      ),
      Event(
        id: '10',
        status: '진행중',
        title: '부서 워크샵',
        host: '한유진',
        imageUrl: 'https://picsum.photos/200/200?random=10',
      ),
    ];
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case '진행중':
        return CupertinoColors.systemGreen;
      case '예정':
        return CupertinoColors.systemBlue;
      case '완료':
        return CupertinoColors.systemGrey;
      default:
        return CupertinoColors.systemGrey;
    }
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
                              color: _getStatusColor(event.status),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              event.status,
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
