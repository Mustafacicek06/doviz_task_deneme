import 'dart:convert';

DovizModel dovizModelFromJson(String str) =>
    DovizModel.fromJson(json.decode(str));

String dovizModelToJson(DovizModel data) => json.encode(data.toJson());

class DovizModel {
  DovizModel({
    required this.usdTry,
    required this.eurTry,
  });

  final double usdTry;
  final double eurTry;

  factory DovizModel.fromJson(Map<String, dynamic> json) => DovizModel(
        usdTry: json["USD_TRY"] == null ? null : json["USD_TRY"].toDouble(),
        eurTry: json["EUR_TRY"] == null ? null : json["EUR_TRY"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "USD_TRY": usdTry == null ? null : usdTry,
        "EUR_TRY": eurTry == null ? null : eurTry,
      };
}
