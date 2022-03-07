part of 'bloc.dart';

@immutable
abstract class MusicListState extends Equatable {
  MusicListState([mProps = const []]) : this._mProps = mProps;
  final List _mProps;
  @override
  List<Object?> get props => this._mProps;
}

class MusicListInitial extends MusicListState {}

class MusicListLoading extends MusicListState {}

class MusicListLoaded extends MusicListState {
  final List<Result>? musics;
  final Result? musicPlayed;

  MusicListLoaded({
    this.musics,
    this.musicPlayed,
  }) : super([
          musics,
          musicPlayed,
        ]);

  MusicListLoaded copyWith({
    List<Result>? musics,
    Result? musicPlayed,
  }) {
    return MusicListLoaded(
      musics: musics,
      musicPlayed: musicPlayed ?? this.musicPlayed,
    );
  }
}

class MusicListError extends MusicListState {
  final String? errorMessage;
  MusicListError({this.errorMessage});
}
