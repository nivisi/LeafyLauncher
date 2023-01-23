import 'package:leafy_data/leafy_data.dart';

class QuickLaunchListModel {
  final Iterable<ApplicationModelBase> applications;
  final int scheme;

  const QuickLaunchListModel(
    this.applications, {
    required this.scheme,
  });
}
