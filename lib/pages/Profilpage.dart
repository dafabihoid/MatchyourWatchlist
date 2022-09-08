import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column (
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(controller: controller,),
          IconButton (
            icon: const Icon(Icons.add),
            onPressed: () {
              final name = controller.text;

              print("bbb");
              createUser(name: name);
            },
          )
        ],
      )
    );
  }

  Future createUser ({required String name}) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc('my-id');

    final json = {
      'name': name,
      'age':21,
      'birthday': DateTime(2001, 7, 28),
    };

    print("aa");

    await docUser.set(json);

    print("hier");
  }
}
