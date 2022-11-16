import 'package:chat_mat/pages/home/Contacts.dart';
import 'package:chat_mat/pages/home/Recents.dart';
import 'package:chat_mat/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State<Home> with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final AuthService _auth = new AuthService();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Scaffold(
            body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Text('ChatMAT'),
                actions: [
                  IconButton(
                      onPressed: () async {
                        await _auth.signOut();
                      },
                      icon: Icon(Icons.logout))
                ],
                pinned: true,
                floating: true,
                bottom: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.white,
                  controller: controller,
                  tabs: [
                    Tab(
                      child: Row(
                        children: [
                          Icon(Icons.contact_page),
                          SizedBox(width: 20.0),
                          const Text("CONTACTS"),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        children: [
                          Icon(Icons.call_outlined),
                          SizedBox(width: 20.0),
                          Text("RECENTS"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: controller,
            children: const <Widget>[
              Contacts(),
              Recents(),
            ],
          ),
        )),
      );
}
