String formatMongoDbTimestamp(dynamic createdAt) {
  if (createdAt == null) {
    return 'No Date'; // Handle null cases
  }

  DateTime createdTime;

  // Handle if the input is a String
  if (createdAt is String) {
    try {
      createdTime = DateTime.parse(createdAt); // Parse ISO8601 string
    } catch (e) {
      return 'Invalid Date'; // Handle parsing error
    }
  }
  // Handle if the input is already a DateTime
  else if (createdAt is DateTime) {
    createdTime = createdAt;
  } else {
    return 'Invalid Date'; // Handle unsupported types
  }

  // Calculate the difference from the current time
  DateTime currentTime = DateTime.now();
  Duration difference = currentTime.difference(createdTime);

  if (difference.inSeconds < 60) {
    return '${difference.inSeconds} seconds ago';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hours ago';
  } else if (difference.inDays < 30) {
    return '${difference.inDays} days ago';
  } else if (difference.inDays < 365) {
    int months = (difference.inDays / 30).floor();
    return '$months months ago';
  } else {
    int years = (difference.inDays / 365).floor();
    return '$years years ago';
  }
}
