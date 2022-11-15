import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/Widgets/MediaView.dart';

class BereitsGesehen extends StatelessWidget {
  const BereitsGesehen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //  backgroundColor: Colors.black12,
        title: const Text("Bereits gesehen"),
      ),
      body: MediaView(),
    );
  }
}
