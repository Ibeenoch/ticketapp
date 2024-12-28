String formatNumber(String number) {
  // Remove any existing spaces or non-numeric characters
  number = number.replaceAll(RegExp(r'\D'), '');

  // Split the number into groups of 4 digits
  final buffer = StringBuffer();
  for (int i = 0; i < number.length; i += 4) {
    if (i > 0) buffer.write(' '); // Add a space between groups
    buffer.write(number.substring(i, i + 4));
  }

  return buffer.toString();
}
