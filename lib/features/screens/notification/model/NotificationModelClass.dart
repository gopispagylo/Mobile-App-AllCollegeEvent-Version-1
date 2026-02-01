class NotificationItem {
  final String title;
  final String message;
  final String time;
  final bool isUnread;
  final int unreadCount;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    this.isUnread = false,
    this.unreadCount = 0,
  });
}
