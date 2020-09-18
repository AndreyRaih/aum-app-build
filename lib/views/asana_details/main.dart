import 'package:aum_app_build/views/asana_details/components/details.dart';
import 'package:aum_app_build/views/asana_details/components/image.dart';
import 'package:aum_app_build/views/ui/buttons.dart';
import 'package:aum_app_build/views/ui/page.dart';
import 'package:flutter/material.dart';

class AsanaDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AumPage(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AsanaDetailImage(),
            Container(
                color: Colors.white,
                width: double.maxFinite,
                padding: EdgeInsets.all(24.0),
                child: Padding(
                    padding: EdgeInsets.only(bottom: 36),
                    child: AsanaDetails()))
          ],
        ),
        isFullscreen: true);
  }
}
