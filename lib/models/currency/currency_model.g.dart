// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_model.dart';

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
