part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchInitiated extends SearchEvent {
  final String query;

  SearchInitiated(this.query);
}

class FetchNextResultPage extends SearchEvent {}
