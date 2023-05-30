import 'country.dart';

class ContinentsModel {
  String? code;
  String? name;
  List<Country>? countries;

  ContinentsModel({this.code, this.name, this.countries});

  factory ContinentsModel.fromJson(Map<String, dynamic> json) {
    return ContinentsModel(
      code: json['code'] as String?,
      name: json['name'] as String?,
      countries: (json['countries'] as List<dynamic>?)
          ?.map((e) => Country.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'countries': countries?.map((e) => e.toJson()).toList(),
      };
}
