part of 'detail_bloc.dart';

@immutable
abstract class DetailEvent {}

class ShowDetail extends DetailEvent {
  final String id;

  ShowDetail(this.id);
}
