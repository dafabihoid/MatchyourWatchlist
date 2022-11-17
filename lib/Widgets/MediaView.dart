import 'package:flutter/material.dart';
import 'package:watchlist/pages/Watchlist/BereitsGesehenPage.dart';
import '../DTOs/MediaDTO.dart';
import '../class/Media.dart';
import '../utils/Enum.dart';



Widget MediaView(Icon1, IconType1, Icon2, IconType2){
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
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
      child: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index){
            return MovieWidget(movie: movies[index], Icon1: Icon1, IconType1: IconType1, Icon2: Icon2, IconType2: IconType2,);
          }

      ),
    ),
  ),
);
}

class MovieWidget extends StatelessWidget {
  final Media movie;
  final Icon Icon1;
  final Icon Icon2;
  final IconType IconType1;
  final IconType IconType2;

  MovieWidget({Key? key, required this.movie, required this.Icon1, required this.Icon2, required this.IconType1, required this.IconType2}) : assert(movie != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(movie.cover),
      title: Text(movie.title),
      subtitle: Text(movie.description),
      trailing: SizedBox( width: 100,
        child: Row(
          children: [

            IconButton(icon: Icon1, onPressed: () {
                switch(IconType1){
                  case IconType.bereitsgsehen: {
                    print("Test");
                  }
                  break;
                  case IconType.add: {

                  }
                  break;
                  case IconType.delete: {

                  }
                  break;
                  case IconType.nochnichtgesehen: {

                  }
                  break;
                  case IconType.nichts: {

                  }
                  break;
                }

            },),
            IconButton(icon: Icon2, onPressed: (){
              switch(IconType2){
                case IconType.bereitsgsehen: {

                }
                break;
                case IconType.add: {

                }
                break;
                case IconType.delete: {

                }
                break;
                case IconType.nochnichtgesehen: {

                }
                break;
                case IconType.nichts: {

                }
                break;
              }
            },)

          ],
        ),
      ),
    );
  }
}
