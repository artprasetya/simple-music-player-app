part of 'bloc.dart';

@immutable
abstract class MusicListEvent {}

/// This [MusicListEventGetData] event triggerred when user fill search field
/// on [MusicListComponent]. This event triggerred on function [onSearchChanged]
/// in [MainInitiator].
///
class MusicListEventGetData extends MusicListEvent {
  /// This event has [query] parameter.
  /// [query] is a string that user fill in search field.
  ///
  final String? query;
  MusicListEventGetData({this.query});
}
