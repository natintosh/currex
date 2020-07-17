import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'currency_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class CurrencyModel {
  @JsonKey(name: 'symbol')
  @HiveField(0)
  String symbol;

  @JsonKey(name: 'name')
  @HiveField(1)
  String name;

  @JsonKey(name: 'symbol_native')
  @HiveField(2)
  String symbolNative;

  @JsonKey(name: 'decimal_digits')
  @HiveField(3)
  num decimalDigits;

  @JsonKey(name: 'rounding')
  @HiveField(4)
  num rounding;

  @JsonKey(name: 'code')
  @HiveField(5)
  String code;

  @JsonKey(name: 'name_plural')
  @HiveField(6)
  String namePlural;

  CurrencyModel(
      {this.symbol,
      this.name,
      this.symbolNative,
      this.decimalDigits,
      this.rounding,
      this.code,
      this.namePlural});

  factory CurrencyModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyModelFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyModelToJson(this);
}
