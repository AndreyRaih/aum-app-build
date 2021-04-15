import 'package:aum_app_build/views/asana_details/bloc/details_cubit.dart';
import 'package:aum_app_build/views/asana_details/bloc/details_state.dart';
import 'package:aum_app_build/views/asana_details/components/details.dart';
import 'package:aum_app_build/views/asana_details/components/image.dart';
import 'package:aum_app_build/views/asana_details/components/progress_log.dart';
import 'package:aum_app_build/views/progress/bloc/progress_state.dart';
import 'package:aum_app_build/views/shared/loader.dart';
import 'package:aum_app_build/views/shared/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AsanaDetailScreen extends StatefulWidget {
  final AsanaNote asana;

  AsanaDetailScreen(this.asana);

  @override
  _AsanaDetailScreenState createState() => _AsanaDetailScreenState();
}

class _AsanaDetailScreenState extends State<AsanaDetailScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DetailsCubit>(context).getDetailsData(widget.asana);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsCubit, DetailsState>(builder: (context, state) {
      if (state is DetailsSuccess) {
        return AumPage(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AsanaDetailImage(state.details.img),
                Container(
                    color: Colors.white,
                    width: double.maxFinite,
                    padding: EdgeInsets.all(24.0),
                    child: Column(children: [
                      AsanaDetails(
                        name: state.details.name,
                        descriptions: state.details.description.dictionary,
                      ),
                      AsanaProgressLog(state.details.log)
                    ]))
              ],
            ),
            isFullscreen: true);
      }
      return AumLoader();
    });
  }
}
