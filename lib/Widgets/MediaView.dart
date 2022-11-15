import 'package:flutter/material.dart';
import '../DTOs/MediaDTO.dart';
import '../class/Media.dart';

Widget MediaView(){
  final movies= [
    Media(
        title: "TestTitle",
        genre: "TestGenre",
        description: "TestDescription",
        cover: "https://image.tmdb.org/t/p/w500/ggFHVNu6YYI5L9pCfOacjizRGt.jpg"
    ),
    Media(
        title: "TestTitle2",
        genre: "TestGenre2",
        description: "TestDescription2",
        cover: "https://image.tmdb.org/t/p/w500/ggFHVNu6YYI5L9pCfOacjizRGt.jpg"
    ),
    Media(
        title: "TestTitle2",
        genre: "TestGenre2",
        description: "TestDescription2",
        cover: "https://image.tmdb.org/t/p/w500/ggFHVNu6YYI5L9pCfOacjizRGt.jpg"
    ),
    Media(
        title: "TestTitle2",
        genre: "TestGenre2",
        description: "TestDescription2",
        cover: "https://image.tmdb.org/t/p/w500/ggFHVNu6YYI5L9pCfOacjizRGt.jpg"
    ),
    Media(
        title: "TestTitle2",
        genre: "TestGenre2",
        description: "TestDescription2",
        cover: "https://image.tmdb.org/t/p/w500/ggFHVNu6YYI5L9pCfOacjizRGt.jpg"
    ),
  ];
return Scaffold(
  body: Container(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index){
            return MovieWidget(movie: movies[index],);
          }

      ),
    ),
  ),
);


}

class MovieWidget extends StatelessWidget {
  final Media movie;
  const MovieWidget({Key? key, required this.movie}) : assert(movie != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(movie.cover),
      title: Text(movie.title),
      subtitle: Text(movie.description),
      trailing: IconButton(icon: Icon(Icons.accessible), onPressed: () {

      },),
    );
  }
}
