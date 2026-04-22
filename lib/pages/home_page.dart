import 'package:flutter/material.dart';
import 'package:zego_uikit_app/cache/shared_prefs.dart';
import 'package:zego_uikit_app/services/call_services.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CallServices callServices = CallServices();

  final usernameController = TextEditingController();
  final idController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ZegoUIKitPrebuiltCallInvitationService()
          .enterAcceptedOfflineCall();
    });

    callServices.onUserLogin(
      SharedPrefs.getString("id"),
      SharedPrefs.getString("username"),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    idController.dispose();
    super.dispose();
  }

  void sendCall() {
    if (!formKey.currentState!.validate()) return;

    ZegoUIKitPrebuiltCallInvitationService().send(
      invitees: [
        ZegoCallUser(
          idController.text,
          usernameController.text,
        ),
      ],
      isVideoCall: false,
      resourceID: "zego_call",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Zego Call System"),
              const SizedBox(height: 20),

              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: "Username"),
                validator: (v) =>
                    v == null || v.isEmpty ? "Enter username" : null,
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: idController,
                decoration: const InputDecoration(labelText: "User ID"),
                validator: (v) =>
                    v == null || v.isEmpty ? "Enter ID" : null,
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: sendCall,
                child: const Text("Call"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}