class Language {
  late String languageId;
  late String language;

  Language (String id, String lang){
    languageId = id;
    language = lang;
  }

  Language.fromJson(Map<String, dynamic> json)
      : languageId = json['languageId'],
        language = json['language'];

  Map<String, dynamic> toJson() => {
    'languageId': languageId,
    'language': language,
  };

}