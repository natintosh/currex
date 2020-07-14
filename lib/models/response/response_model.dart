import 'package:json_annotation/json_annotation.dart';

part 'response_model.g.dart';

@JsonSerializable()
class ResponseModel {
  @JsonKey(name: 'success')
  bool success;
  @JsonKey(name: 'date')
  String date;
  @JsonKey(name: 'base')
  String base;
  @JsonKey(name: 'start_date')
  String startDate;
  @JsonKey(name: 'end_date')
  String endDate;
  @JsonKey(name: 'historical')
  bool historical;
  @JsonKey(name: 'timeseries')
  bool timeseries;
  @JsonKey(name: 'fluctuation')
  bool fluctuation;
  @JsonKey(name: 'result')
  double result;
  @JsonKey(name: 'rates')
  Map<String, dynamic> rates;
  @JsonKey(name: 'query')
  Map<String, dynamic> query;
  @JsonKey(name: 'info')
  Map<String, dynamic> info;
  ResponseModel();

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);
}
