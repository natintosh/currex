// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrencyModelAdapter extends TypeAdapter<CurrencyModel> {
  @override
  final typeId = 0;

  @override
  CurrencyModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrencyModel(
      symbol: fields[0] as String,
      name: fields[1] as String,
      symbolNative: fields[2] as String,
      decimalDigits: fields[3] as num,
      rounding: fields[4] as num,
      code: fields[5] as String,
      namePlural: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CurrencyModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.symbol)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.symbolNative)
      ..writeByte(3)
      ..write(obj.decimalDigits)
      ..writeByte(4)
      ..write(obj.rounding)
      ..writeByte(5)
      ..write(obj.code)
      ..writeByte(6)
      ..write(obj.namePlural);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyModel _$CurrencyModelFromJson(Map<String, dynamic> json) {
  return CurrencyModel(
    symbol: json['symbol'] as String,
    name: json['name'] as String,
    symbolNative: json['symbol_native'] as String,
    decimalDigits: json['decimal_digits'] as num,
    rounding: json['rounding'] as num,
    code: json['code'] as String,
    namePlural: json['name_plural'] as String,
  );
}

Map<String, dynamic> _$CurrencyModelToJson(CurrencyModel instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'name': instance.name,
      'symbol_native': instance.symbolNative,
      'decimal_digits': instance.decimalDigits,
      'rounding': instance.rounding,
      'code': instance.code,
      'name_plural': instance.namePlural,
    };
