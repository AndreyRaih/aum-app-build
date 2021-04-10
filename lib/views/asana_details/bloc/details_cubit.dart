import 'package:aum_app_build/views/asana_details/bloc/details_state.dart';
import 'package:aum_app_build/views/progress/bloc/progress_state.dart';
import 'package:bloc/bloc.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsIsLoading());

  Future getDetailsData(AsanaNote asana) async {
    // TODO: Here should be implemented data fetching
    AsanaDetailItem _details = await Future(() => AsanaDetailItem(
            'Trikonasana',
            'https://data.whicdn.com/images/174118433/original.jpg',
            DetailsDescription('Medium', ['Lying asanas'], ['Legs', 'abs']), [
          AsanaHistoryItem(DateTime.parse('2012-02-27'), 'Today all is {range}', 'perfect'),
          AsanaHistoryItem(DateTime.parse('2012-02-22'), 'Today all is {range}', 'well')
        ]));
    emit(DetailsSuccess(_details));
  }
}
