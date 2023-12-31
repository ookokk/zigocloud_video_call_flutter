import 'package:flutter/material.dart';
import 'package:video_call_pro/src/model/call_model.dart';
import 'package:video_call_pro/src/model/user_model.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'custom_avatar_builder.dart';

class CallView extends StatelessWidget {
  CallView({Key? key, required this.callId}) : super(key: key);
  final String callId;

  final ZegoUIKitPrebuiltCallController? callController =
      ZegoUIKitPrebuiltCallController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltCall(
        appID: CallModel.appID,
        appSign: CallModel.appSign,
        userID: currentUser.id,
        userName: currentUser.name,
        callID: callId,
        controller: callController,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
          ..topMenuBarConfig.isVisible = true
          ..topMenuBarConfig.buttons = [
            ZegoMenuBarButtonName.minimizingButton,
            ZegoMenuBarButtonName.showMemberListButton,
          ]
          ..avatarBuilder = customAvatarBuilder

          ///
          ..onOnlySelfInRoom = (context) {
            if (PrebuiltCallMiniOverlayPageState.idle !=
                ZegoUIKitPrebuiltCallMiniOverlayMachine().state()) {
              ZegoUIKitPrebuiltCallMiniOverlayMachine()
                  .changeState(PrebuiltCallMiniOverlayPageState.idle);
            } else {
              Navigator.of(context).pop();
            }
          },
      ),
    );
  }
}
