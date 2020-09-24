import 'package:aum_app_build/views/ui/buttons.dart';
import 'package:aum_app_build/views/ui/icons.dart';
import 'package:aum_app_build/views/ui/palette.dart';
import 'package:aum_app_build/views/ui/typo.dart';
import 'package:flutter/material.dart';

class PlayerModalPermissions extends StatelessWidget {
  final VoidCallback onAcceptPermissions;
  final VoidCallback onClose;
  PlayerModalPermissions({this.onAcceptPermissions, this.onClose});
  @override
  Widget build(BuildContext context) {
    return _ModalView(
        content: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Icon(
              AumIcon.photo,
              size: 100,
              color: AumColor.additional.withOpacity(0.3),
            )),
        AumText.bold(
          'Permissions',
          size: 34,
        ),
        Container(
            width: 500,
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 24),
                  child: AumText.medium(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    size: 16,
                    color: AumColor.additional,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      width: 145,
                      padding: EdgeInsets.only(right: 8),
                      child: AumOutlineButton(
                        onPressed: onClose,
                        text: 'Cancel',
                      )),
                  Container(
                      width: 145,
                      child: AumPrimaryButton(
                        onPressed: onAcceptPermissions,
                        text: 'Give access',
                      ))
                ],
              )
            ]))
      ],
    ));
  }
}

/**
 * This modal should be updated in future
 */
class PlayerModalOnboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _ModalView(content: AumText.bold('Onboaring'));
  }
}

class _ModalView extends StatelessWidget {
  final Widget content;
  _ModalView({@required this.content});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.25),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: Colors.white),
            child: content),
      ),
    );
  }
}
