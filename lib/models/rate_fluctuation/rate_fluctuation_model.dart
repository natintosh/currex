import 'package:json_annotation/json_annotation.dart';

part 'rate_fluctuation_model.g.dart';

@JsonSerializable()
class RateFluctuationModel {
  @JsonKey(name: 'start_rate')
  double startRate;
  @JsonKey(name: 'end_rate')
  double endRate;
  @JsonKey(name: 'change')
  double change;
  @JsonKey(name: 'change_pct')
  double changePercentage;

  RateFluctuationModel({
    this.startRate,
    this.endRate,
    this.change,
    this.changePercentage,
  });

  factory RateFluctuationModel.fromJson(Map<String, dynamic> json) =>
      _$RateFluctuationModelFromJson(json);
  Map<String, dynamic> toJson() => _$RateFluctuationModelToJson(this);
}
