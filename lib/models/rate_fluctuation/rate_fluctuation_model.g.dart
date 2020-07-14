// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_fluctuation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RateFluctuationModel _$RateFluctuationModelFromJson(Map<String, dynamic> json) {
  return RateFluctuationModel(
    startRate: (json['start_rate'] as num)?.toDouble(),
    endRate: (json['end_rate'] as num)?.toDouble(),
    change: (json['change'] as num)?.toDouble(),
    changePercentage: (json['change_pct'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$RateFluctuationModelToJson(
        RateFluctuationModel instance) =>
    <String, dynamic>{
      'start_rate': instance.startRate,
      'end_rate': instance.endRate,
      'change': instance.change,
      'change_pct': instance.changePercentage,
    };
