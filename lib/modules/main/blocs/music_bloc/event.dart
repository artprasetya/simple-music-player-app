part of 'bloc.dart';

@immutable
abstract class MusicListEvent {}

class MusicListEventGetData extends MusicListEvent {
  final String? query;
  MusicListEventGetData({this.query});
}
