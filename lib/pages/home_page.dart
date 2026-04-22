import 'package:flutter/material.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome to ZegoUIKit Prebuilt Call Invitation Service'),
            ZegoSendCallInvitationButton(
              isVideoCall: true,
              //You need to use the resourceID that you created in the subsequent steps.
              //Please continue reading this document.
              resourceID: "zegouikit_call",
              invitees: [ZegoUIKitUser(id: '12345', name: 'Eslam')],
            ),
          ],
        ),
      ),
    );
  }
}
