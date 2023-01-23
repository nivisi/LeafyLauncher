import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

@LazySingleton(as: InternalApplicationsService)
class InternalApplicationsServiceImpl implements InternalApplicationsService {
  @override
  Future<void> launch(LeafyInternalApplicationModel application) async {}
}
