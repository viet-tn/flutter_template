import 'package:logger/logger.dart';

final log = Logger(
  printer: PrettyPrinter(
    methodCount: 0, // number of method calls to be displayed
  ),
);
