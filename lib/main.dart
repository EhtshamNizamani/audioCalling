import 'package:flutter/material.dart';
import 'package:oneonone_video_calling/utils.dart';
import 'dart:math' as math;
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OnetoOne audio calling',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'OnetoOne audio calling '),
    );
  }
}

final appId = math.Random().nextInt(10000).toString();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController callingIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: Column(
              children: [
                TextField(
                  controller: callingIdController,
                  decoration:
                      const InputDecoration(hintText: 'enter you calling id'),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AudioCallingScreen(
                                  callingId: callingIdController.text.trim())));
                    },
                    child: const Text('call')),
              ],
            ),
          ),
        ));
  }
}

class AudioCallingScreen extends StatelessWidget {
  final callingId;
  const AudioCallingScreen({required this.callingId, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltCall(
        appID: Utils.appId,
        callID: callingId,
        userID: appId,
        appSign: Utils.appSignin,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
          ..onOnlySelfInRoom = (context) {
            Navigator.pop(context);
          },
        userName: 'Ehtsham',
      ),
    );
  }
}
