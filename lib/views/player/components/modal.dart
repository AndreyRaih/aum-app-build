import 'dart:async';

import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/icons.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerModalPermissions extends StatefulWidget {
  final VoidCallback onAcceptPermissions;
  final VoidCallback onClose;
  PlayerModalPermissions({this.onAcceptPermissions, this.onClose});

  @override
  _PlayerModalPermissionsState createState() => _PlayerModalPermissionsState();
}

class _PlayerModalPermissionsState extends State<PlayerModalPermissions>
    with TickerProviderStateMixin {
  AnimationController _modalAnimationController;
  Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    Timer(const Duration(milliseconds: 200), _showModal);
  }

  void _initializeAnimations() {
    _modalAnimationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _opacity =
        Tween<double>(begin: 0, end: 1).animate(_modalAnimationController);
  }

  void _showModal() {
    _modalAnimationController.forward();
  }

  void _hideModal() {
    _modalAnimationController.reverse();
  }

  void _makePermissionRequest() async {
    PermissionStatus status = await Permission.camera.request();
    _hideModal();
    if (status.isGranted) {
      widget.onAcceptPermissions();
    }
  }

  @override
  void dispose() {
    _modalAnimationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: _opacity,
        child: _ModalView(
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
                            onPressed: () {
                              _hideModal();
                              widget.onClose();
                            },
                            text: 'Cancel',
                          )),
                      Container(
                          width: 145,
                          child: AumPrimaryButton(
                            onPressed: () {
                              _makePermissionRequest();
                            },
                            text: 'Give access',
                          ))
                    ],
                  )
                ]))
          ],
        )));
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
