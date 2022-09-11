import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:watchlist/backend/Controller.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final controller = TextEditingController();
  late Future<MovieDTO> futureMovieDTO;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column (
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text("ProfilPage")
        ],
      )
    );
  }
}
