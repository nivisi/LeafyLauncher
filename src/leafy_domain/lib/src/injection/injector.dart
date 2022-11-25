import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injector.config.dart';

@InjectableInit(
  initializerName: r'$initDependencies', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
Future configureDomainDependencies(GetIt injector) async =>
    $initDependencies(injector);
