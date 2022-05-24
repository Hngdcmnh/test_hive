import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:test_hive_flutter/contact.dart';

import 'car.dart';
import 'contact_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
  await path_provider.getApplicationDocumentsDirectory();
  // Hive.init(appDocumentDirectory.path);
  Hive.init('/data/user/0/com.example.test_hive_flutter/files');
  // print('---'+appDocumentDirectory.toString());
  Hive.registerAdapter(ContactAdapter());
  Hive.registerAdapter(CarAdapter());
  Hive.openBox('cars');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Hive',
      home: FutureBuilder(
        future: Hive.openBox(
          'contacts',
        ),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return ContactPage();
            }
          } else {
            return const Scaffold();
          }
        },
      ),
    );
  }


}
