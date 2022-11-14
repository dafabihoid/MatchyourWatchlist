class Provider {
  late int providerId;
  late String providerName;

  Provider (int id, String lang){
    providerId = id;
    providerName = lang;
  }

  Provider.fromJson(Map<String, dynamic> json)
      : providerId = json['providerId'],
        providerName = json['providerName'];

  Map<String, dynamic> toJson() => {
    'providerId': providerId,
    'providerName': providerName,
  };

}