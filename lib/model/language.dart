class Language {
  String code;
  String name;

  Language.fromJson(Map<String, dynamic> json)
      : code = json["code"],
        name = json["name"];
}
