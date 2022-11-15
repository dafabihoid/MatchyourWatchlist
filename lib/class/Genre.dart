class Genre {
  late int genreId;
  late String genreName;

  Genre (String name, int id){
    genreName = name;
    genreId = id;
  }

  Genre.fromJson(Map<String, dynamic> json)
      : genreId = json['id'],
        genreName = json['name'];

  Map<String, dynamic> toJson() => {
    'genreId': genreId,
    'genreName': genreName,
  };

}