part of 'bloc.dart';

abstract class MediaPlayerEvent {}

class MediaPlayerStartListen extends MediaPlayerEvent {}

class MediaPlayerStopListen extends MediaPlayerEvent {}

class MediaPlayerPlay extends MediaPlayerEvent {
  final Result? playMusic;
  final ProcessingState? processingState;

  MediaPlayerPlay({
    this.playMusic,
    this.processingState,
  });
}

class MediaPlayerPause extends MediaPlayerEvent {}

class MediaPlayerRepeat extends MediaPlayerEvent {}

class MediaPlayerClose extends MediaPlayerEvent {}
