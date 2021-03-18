part of 'search_bloc.dart';

@immutable
abstract class SearchState {
  final bool isLoading = false;
  final List<SearchItem> searchResults = [];
  final String error = '';
  final bool hasReachedEndOfResults = false;
}

class SearchInitial extends SearchState {
  final bool isLoading = false;
  final List<SearchItem> searchResults = [];
  final String error = '';
  final bool hasReachedEndOfResults = false;
}

class SearchLoading extends SearchState {
  final bool isLoading = true;
  final List<SearchItem> searchResults = [];
  final String error = '';
  final bool hasReachedEndOfResults = false;
}

class SearchFailure extends SearchState {
  SearchFailure(this.error);
  final bool isLoading = false;
  final List<SearchItem> searchResults = [];
  final String error;
  final bool hasReachedEndOfResults = false;
}

class SearchSuccess extends SearchState {
  SearchSuccess(this.searchResults);
  final bool isLoading = false;
  final List<SearchItem> searchResults;
  final String error = '';
  final bool hasReachedEndOfResults = false;
}

class SearchEnd extends SearchState {
  SearchEnd(this.searchResults);
  final bool isLoading = false;
  final List<SearchItem> searchResults;
  final String error = '';
  final bool hasReachedEndOfResults = true;
}
