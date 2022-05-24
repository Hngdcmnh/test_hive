import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'car_page.dart';
import 'contact.dart';
import 'new_contact_form.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Hive'),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CarPage()),
            );

          }, icon: Icon(Icons.swap_horizontal_circle)),
          IconButton(onPressed: (){
            Hive.box('contacts').clear();
            Hive.box('cars').clear();
          }, icon: Icon(Icons.delete))
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _buildListView()),
          NewContactForm(),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ValueListenableBuilder(
        valueListenable: Hive.box('contacts').listenable(),
        builder: (context, Box box, _) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (BuildContext context, int index) {
              final contact = box.getAt(index) as Contact;

              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(contact.idContact.toString()),
                    Text(contact.name),
                    Text(contact.numberCall.toString()),
                    _numberCar(contact.idContact),
                  ]);
            },
          );
        });
  }

  Widget _numberCar(int index) => ValueListenableBuilder(
      valueListenable: Hive.box('cars').listenable(),
      builder: (context, Box box, _) {
        var number = 0;
        for (var i = 0; i < box.length; i++) {
          if (box.getAt(i).idContact == index) {
            number += 1;
          }
        }
        return Text(number.toString());
      });


}
