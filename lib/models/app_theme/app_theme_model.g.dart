// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_theme_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppThemeAdapter extends TypeAdapter<AppTheme> {
  @override
  final typeId = 1;

  @override
  AppTheme read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AppTheme.Light;
      case 1:
        return AppTheme.Dark;
      case 2:
        return AppTheme.System;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, AppTheme obj) {
    switch (obj) {
      case AppTheme.Light:
        writer.writeByte(0);
        break;
      case AppTheme.Dark:
        writer.writeByte(1);
        break;
      case AppTheme.System:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppThemeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
