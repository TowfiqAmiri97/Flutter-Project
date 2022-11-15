import 'package:chat_mat/models/firebaseuser.dart';
import 'package:chat_mat/pages/authenticate/handler.dart';
import 'package:chat_mat/pages/home/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);

    if (user == null) {
      return Handler();
    } else {
      return Home();
    }
  }
}
