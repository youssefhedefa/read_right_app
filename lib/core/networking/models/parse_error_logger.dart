// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers

class ParseErrorLogger{
  logError(e, s, _options) {
    print('Error: $e');
    print('Stacktrace: $s');}
}