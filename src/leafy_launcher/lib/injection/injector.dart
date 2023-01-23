import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:leafy_domain/leafy_domain.dart';
import 'package:leafy_launcher/presentation/configs/contact_links_config.dart';
import 'package:leafy_launcher/presentation/services/file_system/file_system.dart';
import 'package:leafy_launcher/utils/app_flavour/app_flavour.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injector.config.dart';

final injector = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
Future configureDependencies(
  AppFlavour flavour,
  ContactLinksConfig contactLinksConfig,
) async {
  injector.registerSingleton(flavour);
  injector.registerSingleton(contactLinksConfig);

  await $initGetIt(injector);
  await configureDomainDependencies(injector);
}

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  @preResolve
  Future<FileSystem> get fileSystem => FileSystem.init();
}
