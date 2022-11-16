import 'package:chat_mat/pages/call/OutgoingCall.dart';
import 'package:chat_mat/pages/home/AddContact.dart';
import 'package:chat_mat/pages/home/Items/ContactItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContactsList(aFunction: Call),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const AddContact();
            }));
          },
          child: const Icon(
            Icons.add,
            size: 30,
          )),
    );
  }

  void Call(String email) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return OutgoingCall(
        email: email,
      );
    }));
  }
}
