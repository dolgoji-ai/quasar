import 'package:flutter/cupertino.dart';
import 'event_status.dart';

Color getStatusColor(EventStatus status) {
  switch (status) {
    case EventStatus.inProgress:
      return CupertinoColors.systemGreen;
    case EventStatus.scheduled:
      return CupertinoColors.systemBlue;
    case EventStatus.completed:
      return CupertinoColors.systemGrey;
  }
}
