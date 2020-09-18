import 'package:aum_app_build/views/asana_details/components/details.dart';
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
            Container(
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://zenia.app/wp-content/uploads/2019/12/new_yoga_banner_small.jpg'),
                      fit: BoxFit.fill)),
            ),
            Container(
                color: Colors.white,
                width: double.maxFinite,
                padding: EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 36),
                        child: AsanaDetails()),
                    AumPrimaryButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: 'Back to progress',
                    )
                  ],
                ))
          ],
        ),
        isFullscreen: true);
  }
}
