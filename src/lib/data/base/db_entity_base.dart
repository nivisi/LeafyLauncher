import 'package:hive/hive.dart';

abstract class DbEntityBase extends HiveObject {
  DbEntityBase(this.id);

  @HiveField(0)
  final String id;
}
