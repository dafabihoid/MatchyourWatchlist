import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  var mysql;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    start();

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
              mysqlTest(text: controller.text);
            },
          )
        ],
      )
    );
  }

  void mysqlTest ({required String text}) async {
    var results = await mysql.query('describe user');
    for (var row in results) {
      print(row[0]);
    }
  }

  void start () async{
    final settings = ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: 'bob',
        password: 'wibble',
        db: 'mydb'
    );

    mysql = await MySqlConnection.connect(settings);
  }
}
