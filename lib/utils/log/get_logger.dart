import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'file_output.dart' as file_output;
import 'pretty_console_output.dart';
import 'simple_log_printer.dart';

file_output.FileOutput _fileOutput = file_output.FileOutput();
PrettyConsoleOutput _prettyConsoleOutput = PrettyConsoleOutput();

Logger getLogger({dynamic forObject}) {
  return Logger(
    printer: SimpleLogPrinter(forObject: forObject),
    output: MultiOutput([_fileOutput, _prettyConsoleOutput]),
    filter: ProductionFilter(),
    level: kDebugMode ? Level.verbose : Level.info,
  );
}
