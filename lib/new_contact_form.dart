import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'car.dart';
import 'contact.dart';

class NewContactForm extends StatefulWidget {
  @override
  _NewContactFormState createState() => _NewContactFormState();
}

class _NewContactFormState extends State<NewContactForm> {
  final _formKey = GlobalKey<FormState>();

  late String _name;
  late String _numberCall;

  void addContact(Contact contact) {
    final contactBox = Hive.box('contacts');
    final carBox = Hive.box('cars');

    contactBox.add(contact);

    for(var i =1;i<=5;i++)
      {
        carBox.add(Car(idCar: getNumberCar(),name: 'Car '+getNumberCar().toString(),idContact: getNumberContact()));
      }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onSaved: (value) => _name = value!,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Call Number'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _numberCall = value!,
                ),
              )
            ],
          ),
          ElevatedButton(
            child: Text('Add new contact'),
            onPressed: () {
              _formKey.currentState?.save();
              final newContact = Contact(name: _name, numberCall: int.parse(_numberCall),idContact: getNumberContact());
              addContact(newContact);
            },
          )
        ],
      ),
    );
  }

  int getNumberContact() {
    return Random().nextInt(5);
  }

  int getNumberCar()
  {
    return Random().nextInt(100);
  }
}
