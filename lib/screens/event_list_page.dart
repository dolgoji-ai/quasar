import 'package:flutter/cupertino.dart';

import '../models/event.dart';
import '../services/auth_service.dart';
import '../utils/color_utils.dart';
import '../utils/date_utils.dart';
import '../utils/event_status.dart';
import 'create_page.dart';
import 'event_detail_page.dart';
import 'explore_page.dart';
import 'gallery_page.dart';
import 'profile_page.dart';

class EventListPage extends StatefulWidget {
  const EventListPage({super.key});

  @override
  State<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  final CupertinoTabController _tabController = CupertinoTabController();
  int _previousTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (_tabController.index != 2) {
      setState(() {
        _previousTabIndex = _tabController.index;
      });
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: _tabController,
      tabBar: CupertinoTabBar(
        iconSize: 24,
        height: _tabController.index == 2 ? 0 : 50,
        items: const [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.house)),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.globe)),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.add_circled)),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.photo_on_rectangle),
          ),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_circle)),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) => const EventListContent(),
            );
          case 1:
            return CupertinoTabView(builder: (context) => const ExplorePage());
          case 2:
            return CupertinoTabView(
              builder: (context) => CreatePage(
                onCancel: () {
                  _tabController.index = _previousTabIndex;
                },
              ),
            );
          case 3:
            return CupertinoTabView(builder: (context) => const GalleryPage());
          case 4:
            return CupertinoTabView(builder: (context) => const ProfilePage());
          default:
            return CupertinoTabView(
              builder: (context) => const EventListContent(),
            );
        }
      },
    );
  }
}

class EventListContent extends StatefulWidget {
  const EventListContent({super.key});

  @override
  State<EventListContent> createState() => _EventListContentState();
}

class _EventListContentState extends State<EventListContent> {
  List<Event> events = [];
  bool showUpcomingOnly = false;
  bool showHostingOnly = false;

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  void _loadEvents() {
    events = [
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
        memberList: [
          Member(name: '윤지훈', phoneNumber: '010-5679-0123'),
        ],
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
  }

  void _navigateToDetail(Event event) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => EventDetailPage(event: event)),
    );
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _loadEvents();
    });
  }

  List<Event> get filteredEvents {
    var filtered = events;

    if (showUpcomingOnly) {
      final now = DateTime.now();
      final oneWeekLater = now.add(const Duration(days: 7));
      filtered = filtered.where((event) {
        return event.eventDate.isAfter(now) &&
            event.eventDate.isBefore(oneWeekLater);
      }).toList();
    }

    if (showHostingOnly) {
      filtered = filtered.where((event) {
        return event.host == AuthService().userName;
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('이벤트 목록')),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            CupertinoSliverRefreshControl(onRefresh: _handleRefresh),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: Text(
                  '함께해서 반가워요, ${AuthService().userName}님!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.label,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showUpcomingOnly = !showUpcomingOnly;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey6,
                          border: Border.all(
                            color: showUpcomingOnly
                                ? CupertinoColors.systemGrey
                                : CupertinoColors.systemGrey6,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Upcoming',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: showUpcomingOnly
                                ? CupertinoColors.systemGrey
                                : CupertinoColors.systemGrey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showHostingOnly = !showHostingOnly;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey6,
                          border: Border.all(
                            color: showHostingOnly
                                ? CupertinoColors.systemGrey
                                : CupertinoColors.systemGrey6,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Hosting',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: showHostingOnly
                                ? CupertinoColors.systemGrey
                                : CupertinoColors.systemGrey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final event = filteredEvents[index];
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    event.imageUrl,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 120,
                                        height: 120,
                                        color: CupertinoColors.systemGrey5,
                                        child: const Icon(
                                          CupertinoIcons.photo,
                                          color: CupertinoColors.systemGrey,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Opacity(
                                    opacity: 0.8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: getStatusColor(event.status),
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                        ),
                                      ),
                                      child: Text(
                                        event.status.displayName,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: CupertinoColors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.calendar,
                                      size: 16,
                                      color: CupertinoColors.systemGrey,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      formatEventDate(event.eventDate),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: CupertinoColors.systemGrey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.person_2_fill,
                                      size: 16,
                                      color: CupertinoColors.systemGrey,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '모임원 ${event.memberList.length}명',
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
                }, childCount: filteredEvents.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
