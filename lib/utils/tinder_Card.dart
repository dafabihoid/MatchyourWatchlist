import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../class/Movie.dart';
import 'CardProvider.dart';

class TinderCard extends StatefulWidget {
  final Movie movie;
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
  @override
  void initState(){
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      final provider = Provider.of<CardProvider>(context, listen: false);
      provider.setScreenSize(size);
    });
  }

  @override
  Widget build(BuildContext) => SizedBox.expand(
      child: widget.isFront ? buildFrontCard() : buildCard(),
  );

  Widget buildFrontCard() => GestureDetector(
        child: LayoutBuilder(
            builder: (context, constraints) {
          final center = constraints.smallest.center(Offset.zero);
          final provider = Provider.of<CardProvider>(context);
          final position = provider.getPosition;
          final angle = provider.angle * pi /180;
          final rotatedMatrix = Matrix4.identity()
          ..translate(center.dx,center.dy)
          ..rotateZ(angle)
          ..translate(-center.dx,-center.dy);



          int milliseconds = provider.getIsMoving ? 0 : 400;

          return AnimatedContainer(
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: milliseconds),
            transform: rotatedMatrix..translate(position.dx, position.dy),
            child: buildCard(),
          );
        }
        ),
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
    onLongPress:() {
          print("TEsT");
    },
      );

  Widget buildCard() => ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(widget.movie.cover),
          fit: BoxFit.cover,
        )),
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.7, 1],
            )),
            child: Container(
                padding: EdgeInsets.all(20),
                child: Column(children: [
                  Spacer(),
                  buildTitle(),
                  buildGenre(),
                ]))),
      ));

  Widget buildTitle() => Row(
        children: [
          Text(
            widget.movie.title,
            style: TextStyle(
                fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      );

  Widget buildGenre() => Row(children: [
        Text(
          widget.movie.genre,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        )
      ]);
}
