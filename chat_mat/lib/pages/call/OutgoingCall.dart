import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class OutgoingCall extends StatefulWidget {
  String email = "";
  OutgoingCall({
    required this.email,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OutgoingCall();
  }
}

class _OutgoingCall extends State<OutgoingCall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(75))),
              child: Center(
                  child: Text(
                widget.email.substring(0, 1).toUpperCase(),
                style: TextStyle(fontSize: 120, color: Colors.white),
              ))),
          SizedBox(
            height: 20,
          ),
          Text(widget.email,
              style: TextStyle(fontSize: 20, overflow: TextOverflow.ellipsis)),
          SizedBox(
            height: 60,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button(Icons.volume_off_sharp, Colors.grey[350]!,
                  Colors.grey[400]!, () {}),
              SizedBox(
                width: 20,
              ),
              button(
                  Icons.mic_off, Colors.grey[350]!, Colors.grey[400]!, () {}),
              SizedBox(
                width: 20,
              ),
              button(Icons.call_end, Colors.red[600]!, Colors.red[900]!, () {
                Navigator.pop(context);
              })
            ],
          )
        ],
      ),
    );
  }

  ElevatedButton button(
      IconData icon, Color backColor, Color pressColor, Function onPress) {
    bool _isSelected = false;
    Color _backColor = backColor;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (!_isSelected) {
            _backColor = pressColor;
          } else {
            _backColor = backColor;
          }
          _isSelected = !_isSelected;
          onPress();
        });
      },
      child: Icon(icon),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(CircleBorder()),
        padding: MaterialStateProperty.all(EdgeInsets.all(20)),
        backgroundColor:
            MaterialStateProperty.all(_backColor), // <-- Button color
      ),
    );
  }
}
