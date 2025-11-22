import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quasar/models/event.dart';
import 'package:quasar/repositories/event_repository.dart';
import 'package:quasar/services/auth_service.dart';
import 'package:quasar/utils/color_utils.dart';
import 'package:quasar/utils/date_utils.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  final AuthService _authService = AuthService();
  final EventRepository _eventRepository = EventRepository();
  List<Event> events = [];
  bool showUpcomingOnly = false;
  bool showHostingOnly = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    setState(() {
      isLoading = true;
    });

    final loadedEvents = await _eventRepository.getEvents(
      upcomingOnly: showUpcomingOnly,
      hostFilter: showHostingOnly ? _authService.userName : null,
    );

    setState(() {
      events = loadedEvents;
      isLoading = false;
    });
  }

  void _navigateToDetail(Event event) {
    context.go('/events/${event.id}', extra: event);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이벤트 목록'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.push('/notifications'),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 52,
        height: 52,
        child: FloatingActionButton(
          onPressed: () => context.go('/events/create'),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          splashColor: Colors.transparent,
          highlightElevation: 0,
          shape: CircleBorder(
            side: BorderSide(color: Colors.grey[300]!, width: 1),
          ),
          child: const Icon(Icons.add, size: 28),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadEvents,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                  child: Text(
                    '함께해서 반가워요, ${_authService.userName}님!',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                  child: Row(
                    children: [
                      FilterChip(
                        label: const Text('Upcoming'),
                        selected: showUpcomingOnly,
                        showCheckmark: false,
                        onSelected: (selected) {
                          setState(() {
                            showUpcomingOnly = selected;
                          });
                          _loadEvents();
                        },
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Hosting'),
                        selected: showHostingOnly,
                        showCheckmark: false,
                        onSelected: (selected) {
                          setState(() {
                            showHostingOnly = selected;
                          });
                          _loadEvents();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final event = events[index];
                  return Column(
                    children: [
                      InkWell(
                        onTap: () => _navigateToDetail(event),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
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
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return Container(
                                                width: 120,
                                                height: 120,
                                                color: Colors.grey[300],
                                                child: Icon(
                                                  Icons.photo,
                                                  color: Colors.grey[600],
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
                                            borderRadius:
                                                const BorderRadius.only(
                                                  bottomLeft: Radius.circular(
                                                    8,
                                                  ),
                                                  bottomRight: Radius.circular(
                                                    8,
                                                  ),
                                                ),
                                          ),
                                          child: Text(
                                            event.status.displayName,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.white,
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.workspace_premium,
                                          size: 16,
                                          color: Colors.grey[600],
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          event.host,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          size: 16,
                                          color: Colors.grey[600],
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          formatEventDate(event.eventDate),
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 16,
                                          color: Colors.grey[600],
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          event.location,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.people,
                                          size: 16,
                                          color: Colors.grey[600],
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '모임원 ${event.memberList.length}명',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
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
                      ),
                      if (index < events.length - 1)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.grey[300],
                          ),
                        ),
                    ],
                  );
                }, childCount: events.length),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
