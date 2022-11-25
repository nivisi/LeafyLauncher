import 'package:leafy_data/leafy_data.dart';

abstract class QuickLaunchApplicationsService {
  int get amountOfMaximumListLength;

  Future<ApplicationModelBase> restoreLeftApp();
  Future<ApplicationModelBase> restoreRightApp();
  Future<List<ApplicationModelBase>> restoreHomeList();

  Future<void> storeLeftApp(ApplicationModelBase application);
  Future<void> storeRightApp(ApplicationModelBase application);
  Future<void> storeAppList(Iterable<ApplicationModelBase> applications);
}
