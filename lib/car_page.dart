import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'car.dart';
import 'contact.dart';

class CarPage extends StatelessWidget {
  const CarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Car'),),
      body: _buildListCar(),
    );
  }
}

Widget _buildListCar() {
  return ValueListenableBuilder(
      valueListenable: Hive.box('cars').listenable(),
      builder: (context, Box box, _) {
        return ListView.builder(
          itemCount: box.length,
          itemBuilder: (BuildContext context, int index) {
            final contact = box.getAt(index) as Car;
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(contact.idContact.toString()),
                  Text(contact.name),
                ]);
          },
        );
      });
}
