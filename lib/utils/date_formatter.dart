String timeAgo(DateTime iso) {
  final now = DateTime.now().toUtc();
  final diff = now.difference(iso.toUtc());

  if (diff.inDays > 365) return '${(diff.inDays / 365).floor()} years ago';
  if (diff.inDays > 30) return '${(diff.inDays / 30).floor()} months ago';
  if (diff.inDays > 0) return '${diff.inDays} days ago';
  if (diff.inHours > 0) return '${diff.inHours} hours ago';
  if (diff.inMinutes > 0) return '${diff.inMinutes} minutes ago';
  return 'just now';
}
