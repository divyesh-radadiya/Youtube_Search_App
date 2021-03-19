import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_search_app/data/model/detail/model_detail.dart';
import 'package:youtube_search_app/data/model/detail/video_item.dart';
import 'package:youtube_search_app/data/repository/youtube_repository.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc(this.repository) : super(DetailInitial());
  YoutubeRepository repository;

  @override
  Stream<DetailState> mapEventToState(
    DetailEvent event,
  ) async* {
    if (event is ShowDetail) {
      yield DetailLoading();

      try {
        final videoItem = await repository.fetchVideoInfo(id: event.id);
        yield DetailSuccess(videoItem);
      } on YoutubeVideoError catch (e) {
        yield DetailFailure(e.message);
      } on NoSuchVideoException catch (e) {
        yield DetailFailure(e.message);
      }
    }
  }
}
