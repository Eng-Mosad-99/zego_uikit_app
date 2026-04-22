import 'package:zego_uikit_app/constants/constants.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class CallServices {
  static final CallServices _instance = CallServices._internal();
  factory CallServices() => _instance;
  CallServices._internal();

  Future<void> onUserLogin(String userID, String userName) async {
    await ZegoUIKitPrebuiltCallInvitationService().init(
      appID: Constants.appID,
      appSign: Constants.appSign,
      userID: userID,
      userName: userName,
      plugins: [ZegoUIKitSignalingPlugin()],
      notificationConfig: ZegoCallInvitationNotificationConfig(
        androidNotificationConfig: ZegoCallAndroidNotificationConfig(),
      ),
    );
  }

  void onUserLogout() {
    ZegoUIKitPrebuiltCallInvitationService().uninit();
  }
}
