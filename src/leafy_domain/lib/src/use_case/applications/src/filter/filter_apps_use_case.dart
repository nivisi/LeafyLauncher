import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';

@lazySingleton
class FilterAppsUseCase {
  List<ApplicationModelBase> call(
    List<ApplicationModelBase> apps,
    String query,
  ) {
    if (query.isEmpty) {
      return apps;
    }

    final queryToLower = query.toLowerCase();

    return apps
        .where((e) => e.name.toLowerCase().contains(queryToLower))
        .toList();
  }
}
