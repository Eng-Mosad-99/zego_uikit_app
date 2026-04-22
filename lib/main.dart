import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zego_uikit_app/pages/home_page.dart';
import 'package:zego_uikit_app/pages/login_page.dart';
import 'cache/shared_prefs.dart';
import 'firebase_options.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SharedPrefs.init();

  /// set navigator key
  ZegoUIKitPrebuiltCallInvitationService()
      .setNavigatorKey(navigatorKey);

  await ZegoUIKit().initLog();

  /// init system UI (once only)
  await ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI([
    ZegoUIKitSignalingPlugin(),
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  bool get isLogged =>
      SharedPrefs.getString("username").isNotEmpty &&
      SharedPrefs.getString("id").isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: isLogged ? const HomePage() : const LoginPage(),
    );
  }
}