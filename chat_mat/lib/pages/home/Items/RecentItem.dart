import 'package:chat_mat/models/RecentCallModel.dart';
import 'package:chat_mat/services/RecentCallServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RecentItem extends StatefulWidget {
  RecentCallModel recent;
  RecentItem({
    required this.recent,
    Key? key,
  }) : super(key: key);

  @override
  State<RecentItem> createState() => _RecentItemState();
}

class _RecentItemState extends State<RecentItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.all(10),
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Center(
                  child: Text(
                widget.recent.email.substring(0, 1).toUpperCase(),
                style: TextStyle(fontSize: 50, color: Colors.white),
              ))),
          Expanded(
              child: Row(
            children: [
              Container(
                width: (MediaQuery.of(context).size.width - 170),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.recent.email,
                        style: TextStyle(
                            fontSize: 20, overflow: TextOverflow.ellipsis)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.recent.Date,
                        style: TextStyle(
                            fontSize: 16, overflow: TextOverflow.ellipsis))
                  ],
                ),
              ),
              Container(
                width: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(widget.recent.Time + " min",
                        style: TextStyle(fontSize: 14)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.recent.DateTime, style: TextStyle(fontSize: 14))
                  ],
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}

class RecentsList extends StatelessWidget {
  RecentsList({
    Key? key,
  }) : super(key: key);

  List<RecentCallModel> list = RecentCallServices().get_recent_call();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: ((context, index) {
                  return RecentItem(
                    recent: list[index],
                  );
                })))
      ],
    );
  }
}
