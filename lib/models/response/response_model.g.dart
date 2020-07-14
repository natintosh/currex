// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseModel _$ResponseModelFromJson(Map<String, dynamic> json) {
  return ResponseModel()
    ..success = json['success'] as bool
    ..date = json['date'] as String
    ..base = json['base'] as String
    ..startDate = json['start_date'] as String
    ..endDate = json['end_date'] as String
    ..historical = json['historical'] as bool
    ..timeseries = json['timeseries'] as bool
    ..fluctuation = json['fluctuation'] as bool
    ..result = (json['result'] as num)?.toDouble()
    ..rates = json['rates'] as Map<String, dynamic>
    ..query = json['query'] as Map<String, dynamic>
    ..info = json['info'] as Map<String, dynamic>;
}

Map<String, dynamic> _$ResponseModelToJson(ResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'date': instance.date,
      'base': instance.base,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'historical': instance.historical,
      'timeseries': instance.timeseries,
      'fluctuation': instance.fluctuation,
      'result': instance.result,
      'rates': instance.rates,
      'query': instance.query,
      'info': instance.info,
    };
