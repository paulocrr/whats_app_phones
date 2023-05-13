extension StringExtension on String {
  String get formatPhoneNumber {
    return replaceAll('(', '').replaceAll(')', '').replaceAll(' ', '');
  }
}
