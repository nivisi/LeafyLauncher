import 'package:leafy_data/leafy_data.dart';

abstract class InternalApplicationsService {
  Future<void> launch(LeafyInternalApplicationModel application);
}
