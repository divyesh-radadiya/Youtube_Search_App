part of 'detail_bloc.dart';

@immutable
abstract class DetailState {
  final bool isLoading = false;
  final VideoItem videoItem = null;
  final String error = '';
}

class DetailInitial extends DetailState {
  @override
  final bool isLoading = false;
  final VideoItem videoItem = null;
  final String error = '';
}

class DetailLoading extends DetailState {
  final bool isLoading = true;
  final VideoItem videoItem = null;
  final String error = '';
}

class DetailFailure extends DetailState {
  final bool isLoading = false;
  final VideoItem videoItem = null;
  final String error;

  DetailFailure(this.error);
}

class DetailSuccess extends DetailState {
  final bool isLoading = false;
  final VideoItem videoItem;
  final String error = '';

  DetailSuccess(this.videoItem);
}
