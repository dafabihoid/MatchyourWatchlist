import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/utils/myThemes.dart';
import '../../class/Media.dart';
import '../utils/CardProvider.dart';

class TinderCard extends StatefulWidget {
  final Media movie;
  final bool isFront;

  const TinderCard({
    Key? key,
    required this.movie,
    required this.isFront,
  }) : super(key: key);

  @override
  State<TinderCard> createState() => _TinderCardState();
}

class _TinderCardState extends State<TinderCard> {
  var center;
  var position;
  var angle;

  double currentOpacity = 0;

  double get getCurrentOpacity => currentOpacity;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      final provider = Provider.of<CardProvider>(context, listen: false);
      provider.setScreenSize(size);

    });
  }

  @override
  Widget build(BuildContext) {
    return SizedBox.expand(
          child: widget.isFront ? buildFrontCard() : buildCard(),
        );
  }

  Widget buildFrontCard() => GestureDetector(
        child: LayoutBuilder(builder: (context, constraints) {
          center = constraints.smallest.center(Offset.zero);
          final provider = Provider.of<CardProvider>(context);
          position = provider.getPosition;
          angle = provider.angle * pi / 180;
          final rotatedMatrix = Matrix4.identity()
            ..translate(center.dx, center.dy)
            ..rotateZ(angle)
            ..translate(-center.dx, -center.dy);

          int milliseconds = provider.getIsMoving ? 0 : 400;

          return AnimatedContainer(
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: milliseconds),
              transform: rotatedMatrix..translate(position.dx, position.dy),
              child: Stack(children: [
                buildCard(),
                decisionStatus(),
                buildStemps(),
              ]));
        }),
        onPanStart: (details) {
          final provider = Provider.of<CardProvider>(context, listen: false);
          provider.startPosition(details);
        },
        onPanUpdate: (details) {
          final provider = Provider.of<CardProvider>(context, listen: false);
          provider.updatePosition(details);
        },
        onPanEnd: (details) {
          final provider = Provider.of<CardProvider>(context, listen: false);
          setState(() {
            provider.endPosition();
          });
        },
        onLongPress: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30)
              )
            ),
              builder: (BuildContext context) {
              return DraggableScrollableSheet(
                  expand: false,
                  maxChildSize: 0.93,
                  minChildSize: 0.32,
                  builder: (context, scrollController) => SingleChildScrollView(
                    controller: scrollController,
                    child: ExpandedInformation(),
                ),
              );
          }
          );
        },
      );

  Widget buildCard() => ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: CachedNetworkImageProvider(widget.movie.cover.toString()),
          fit: BoxFit.cover,
        )),
        child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.7, 1],
            )),
            child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  Spacer(),
                  buildTitle(),
                  buildGenre(),
                ]))),
      ));

  Widget buildTitle() => Row(
        children: [
          Expanded(child: Text(
            widget.movie.title,
            style: const TextStyle(
                fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
          ))

        ],
      );

  Widget buildGenre() => Row(children: [
    Expanded(child: Text(
          widget.movie.genres,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        )
    )]);

  Widget decisionStatus() {
    final provider = Provider.of<CardProvider>(context);
    final status = provider.getStatus();

    switch (status) {
      case CardStatus.like:
        final child = buildColorCard(Colors.green);
        //tempColor = Colors.lightGreen;
        //break;
        return child;
      case CardStatus.dislike:
        final child = buildColorCard(Colors.red);
        //tempColor = Colors.red;
        //break;
        return child;
      return Container();


      default:
        return Container();
    }
  }

  //STEMPS

  buildStemps() {
    final provider = Provider.of<CardProvider>(context);
    final status = provider.getStatus();

    switch (status) {
      case CardStatus.like:
        final child = buildStamp(angle: -0.5, color: Colors.green, iconSymbol: Icons.favorite);
        //tempColor = Colors.lightGreen;
        //break;
        return Positioned(top:64, left:40, child: child);
      case CardStatus.dislike:
        final child = buildStamp(angle: 0.5, color: Colors.red, iconSymbol: Icons.heart_broken);
        //tempColor = Colors.lightGreen;
        //break;
        return Positioned(top:64, right:40, child: child);


      default:
        return Container();
    }
  }

  Widget buildStamp({
    double angle = 0,
    required Color color,
    required IconData iconSymbol,
  }) {
    return Transform.rotate(
      angle: angle,
      child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.transparent, width: 0),
          ),
          child: Icon (
            iconSymbol,
            color: Colors.white,
            size: 50,
          ),
      ),
    );
  }

  Widget buildColorCard(Color color) =>LayoutBuilder(builder: (context, constraints) {
    final provider = Provider.of<CardProvider>(context);
    int milliseconds = provider.getIsMoving ? 0 : 400;

    return AnimatedContainer(
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: milliseconds),
    //    transform: rotatedMatrix..translate(position.dx-100, position.dy),
        child: Stack(children: [
        ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
         // decoration: BoxDecoration(
         //   gradient: LinearGradient(colors: [Color(color).withOpacity(0.1),Color(color).withOpacity(0.5)])
        //  ),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color, width: 8),
          ),
        )
    )
        ]));
  });

  Widget ExpandedInformation() {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Positioned(
              top: 15,
              child: Container(
                width: 60,
                height: 7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: themeProvider.isDarkMode ? Colors.white : Colors.black),
              )
          ),
          Column(
              children:[

                Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                  children: [
                    SizedBox(height: 30,),
                    Row(
                      children: [

                        Expanded(child: Text(widget.movie.title.toString(), style: TextStyle(fontSize: 30),)),

                      ],
                    ),
                    Row(
                      children: [

                        Expanded(child: Text(widget.movie.genres.toString(), style: TextStyle(fontSize: 18,color: Colors.grey.withOpacity(0.5)),),),
                        Spacer()
                      ],
                    ),
                    Row(
                      children: [
                        Text("Provider: ",style: TextStyle(fontSize: 20)),
                        Expanded(child:Text(widget.movie.providers, style: TextStyle(fontSize: 20),),),
                        Spacer()
                      ],
                    ),
                    SizedBox(height: 30,),
                        Row(
                        children: [
                        Text("Beschreibung:",style: TextStyle(fontSize: 20)),
                        Spacer()
                        ],
                        ),
                        SizedBox(height: 5,),
                        Text(widget.movie.description.toString(), style: TextStyle(fontSize: 20)),








                  ],
                )),
                /*     Row(
                          children: [
                          Spacer(),
                          IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close,size: 25,)),   /// CLOSE BUTTON ?!?!?!
                        ],
                        ), */
              ]
          ),
        ]
    );
  }

}
