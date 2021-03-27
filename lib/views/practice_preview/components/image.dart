import 'package:aum_app_build/views/practice_preview/bloc/preview_cubit.dart';
import 'package:aum_app_build/views/practice_preview/bloc/preview_state.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreviewImg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ImageProvider _img = (BlocProvider.of<PreviewCubit>(context).state as PreviewIsReady).preview.img;
    return Container(
        height: 340,
        decoration: BoxDecoration(
            color: AumColor.accent,
            image: DecorationImage(image: _img, fit: BoxFit.cover, alignment: Alignment.bottomCenter)));
  }
}
