import 'package:json_annotation/json_annotation.dart';

part 'currency_model.g.dart';

@JsonSerializable()
class CurrencyModel {

  @JsonKey(name: 'symbol')
  String symbol;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'symbol_native')
  String symbolNative;
  @JsonKey(name: 'decimal_digits')
  num decimalDigits;
  @JsonKey(name: 'rounding')
  num rounding;
  @JsonKey(name: 'code')
  String code;
  @JsonKey(name: 'name_plural')
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
