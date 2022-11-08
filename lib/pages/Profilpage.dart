import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/backend/Controller.dart';

import '../DTOs/MediaDTO.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final controller = TextEditingController();
  late Future<MediaDTO> futureMovieDTO;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column (
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
          Text("ProfilPage"),
          ElevatedButton.icon(onPressed: () => FirebaseAuth.instance.signOut(), icon: Icon(Icons.add), label: Text("Sign UP"))

        ],
      )
    );
  }
}
