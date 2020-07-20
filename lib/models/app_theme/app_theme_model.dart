import 'package:hive/hive.dart';

part 'app_theme_model.g.dart';

@HiveType(typeId: 1)
enum AppTheme {
  @HiveField(0)
  Light,

  @HiveField(1)
  Dark,

  @HiveField(2)
  System,
}
