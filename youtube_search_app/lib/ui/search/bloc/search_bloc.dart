import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_search_app/data/model/search/model_search.dart';
import 'package:youtube_search_app/data/repository/youtube_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final YoutubeRepository _youtubeRepository;
  SearchBloc(this._youtubeRepository) : super(SearchInitial());
  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchInitiated) {
      yield* mapSearchInitiated(event);
    } else if (event is FetchNextResultPage) {
      yield* mapFetchNextResultPage();
    }
  }

  Stream<SearchState> mapSearchInitiated(SearchInitiated event) async* {
    if (event.query.isEmpty) {
      yield SearchInitial();
    } else {
      yield SearchLoading();

      try {
        final searchResult = await _youtubeRepository.searchVideos(event.query);
        yield SearchSuccess(searchResult.toList());
      } on YoutubeSearchError catch (e) {
        yield SearchFailure(e.message);
      } on NoSearchResultsException catch (e) {
        yield SearchFailure(e.message);
      }
    }
  }

  Stream<SearchState> mapFetchNextResultPage() async* {
    final currentState = state;
    try {
      final nextPageResults = await _youtubeRepository.fetchNextResultPage();
      yield SearchSuccess(
          currentState.searchResults + nextPageResults.toList());
    } on NoNextPageTokenException catch (_) {
      yield SearchEnd(currentState.searchResults);
    } on SearchNotInitiatedException catch (e) {
      yield SearchFailure(e.message);
    } on YoutubeSearchError catch (e) {
      yield SearchFailure(e.message);
    }
  }
}
