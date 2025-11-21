import 'package:flutter/material.dart';

import '../enums/event_status.dart';

Color getStatusColor(EventStatus status) {
  switch (status) {
    case EventStatus.inProgress:
      return Colors.green;
    case EventStatus.scheduled:
      return Colors.blue;
    case EventStatus.completed:
      return Colors.grey;
  }
}
