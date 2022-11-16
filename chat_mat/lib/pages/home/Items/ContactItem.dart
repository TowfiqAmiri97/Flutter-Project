import 'package:agora_rtc_ng/agora_rtc_ng.dart';
import 'package:chat_mat/pages/call/OutgoingCall.dart';
import 'package:chat_mat/services/ContactService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactItem extends StatefulWidget {
  String email = "";
  final Function(String email) aFunction;

  ContactItem({
    required this.email,
    required this.aFunction,
    Key? key,
  }) : super(key: key);

  @override
  State<ContactItem> createState() => _ContactItem();
}

class _ContactItem extends State<ContactItem> {
  static const String appId = "";
  String channelName = "<--Insert channel name here-->";
  String token = "<--Insert authentication token here-->";
  int uid = 0; // uid of the local user

  int? _remoteUid; // uid of the remote user
  bool _isJoined = false; // Indicates if the local user has joined the channel
  late RtcEngine agoraEngine; // Agora engine instance

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>(); // Global key to access the scaffold

  void join() async {
    // Set channel options including the client role and channel profile
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    await agoraEngine.joinChannelWithOptions(
      token: token,
      channelId: channelName,
      options: options,
      uid: uid,
    );
  }

  void leave() {
    setState(() {
      _isJoined = false;
      _remoteUid = null;
    });
    agoraEngine.leaveChannel();
  }

  @override
  void dispose() async {
    await agoraEngine.leaveChannel();
    super.dispose();
  }

  showMessage(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  void initState() {
    super.initState();
    // Set up an instance of Agora engine
    setupVoiceSDKEngine();
  }

  Future<void> setupVoiceSDKEngine() async {
    // retrieve or request microphone permission
    await [Permission.microphone].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(const RtcEngineContext(appId: appId));

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          showMessage(
              "Local user uid:${connection.localUid} joined the channel");
          setState(() {
            _isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          showMessage("Remote user uid:$remoteUid joined the channel");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          showMessage("Remote user uid:$remoteUid left the channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: MaterialButton(
        color: Colors.blue[200],
        onPressed: () {
          widget.aFunction(widget.email);
        },
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Center(
                    child: Text(
                  widget.email.substring(0, 1).toUpperCase(),
                  style: TextStyle(fontSize: 50, color: Colors.white),
                ))),
            Expanded(
                child: Text(widget.email,
                    style: TextStyle(
                        fontSize: 20, overflow: TextOverflow.ellipsis))),
          ],
        ),
      ),
    );
  }

  Widget _status() {
    String statusText;

    if (!_isJoined)
      statusText = 'Join a channel';
    else if (_remoteUid == null)
      statusText = 'Waiting for a remote user to join...';
    else
      statusText = 'Connected to remote user, uid:$_remoteUid';

    return Text(
      statusText,
    );
  }
}

class ContactsList extends StatelessWidget {
  final Function(String email) aFunction;

  ContactsList({
    required this.aFunction,
    Key? key,
  }) : super(key: key);

  List<String> list = ContactService().get_contact();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: ((context, index) {
                  return ContactItem(
                    email: list[index],
                    aFunction: aFunction,
                  );
                })))
      ],
    );
  }
}
