class MediaProvider {
  late int providerId;
  late String providerName;

  MediaProvider (int id, String lang){
    providerId = id;
    providerName = lang;
  }

  MediaProvider.fromJson(Map<String, dynamic> json)
      : providerId = json['providerId'],
        providerName = json['providerName'];

  Map<String, dynamic> toJson() => {
    'providerId': providerId,
    'providerName': providerName,
  };

}