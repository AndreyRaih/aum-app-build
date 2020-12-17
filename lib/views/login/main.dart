import 'package:aum_app_build/data/constants.dart';
import 'package:aum_app_build/views/login/components/actions.dart';
import 'package:aum_app_build/views/login/components/modal.dart';
import 'package:aum_app_build/views/login/components/slider.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> with LoginFormModal {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey[300],
            image: DecorationImage(
              image: AssetImage(MAIN_BACKGROUND_IMAGE),
              alignment: Alignment(-0.5, 0),
              fit: BoxFit.fitHeight,
            )),
        child: Container(
          padding: EdgeInsets.all(48),
          color: Colors.white70.withOpacity(0.75),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LoginSlider(),
                LoginActions(
                  onCallForm: (type) => displayBottomSheet(context, type),
                )
              ],
            ),
          ),
        ));
  }
}
