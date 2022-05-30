import 'package:code/model/language.dart';

class Country {
  String name;
  String? capital;
  String? currency;
  String? native;
  String? emoji;
  List<Language>? language;

  Country.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        capital = json["capital"],
        currency = json["currency"],
        native = json["native"],
        emoji = json["emoji"],
        language = json['languages'] != null
            ? List<Language>.from(
                json['languages']?.map((x) => Language.fromJson(x)))
            : null;
}
