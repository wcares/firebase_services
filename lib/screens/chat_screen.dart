import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/widgets/chat/messages.dart';
import 'package:firebase_chat/widgets/chat/new_message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging fbm = FirebaseMessaging.instance;
    fbm.requestPermission();
    fbm.subscribeToTopic('chat');
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print("Got a message whilst in the foreground");
    //   print('Message data: ${message.data}');
    //   if (message.notification != null) {
    //     print(
    //         "Message also contained a notification: ${message.notification.body}");
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterChat'),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                value: "logout",
                child: Row(
                  children: const [
                    Icon(
                      Icons.exit_to_app,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: const [
          Expanded(
            child: Messages(),
          ),
          NewMessage(),
        ],
      ),
    );
  }
}
