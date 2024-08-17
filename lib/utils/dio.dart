import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final logInterceptor = PrettyDioLogger(
  // ignore: avoid_redundant_argument_values
  enabled: kDebugMode,
);
