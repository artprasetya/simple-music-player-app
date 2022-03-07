part of 'bloc.dart';

abstract class MediaPlayerState extends Equatable {
  MediaPlayerState([mProps = const []]) : this._mProps = mProps;
  final List _mProps;
  @override
  List<Object?> get props => this._mProps;
}

class MediaPlayerInitial extends MediaPlayerState {}

class MediaPlayerOnListen extends MediaPlayerState {
  final AudioPlayer? audioPlayer;
  final Result? musicPlaying;
  final bool? showPlayer;

  MediaPlayerOnListen({
    this.audioPlayer,
    this.musicPlaying,
    this.showPlayer,
  }) : super([
          audioPlayer,
          musicPlaying,
          showPlayer,
        ]);

  MediaPlayerOnListen copyWith({
    AudioPlayer? audioPlayer,
    bool? isPlaying,
    ProcessingState? processingState,
    Result? musicPlaying,
    bool? showPlayer,
  }) {
    return MediaPlayerOnListen(
      showPlayer: showPlayer ?? this.showPlayer,
      audioPlayer: audioPlayer ?? this.audioPlayer,
      musicPlaying: musicPlaying,
    );
  }
}
