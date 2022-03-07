import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:simple_music_player_app/models/result.dart';

part 'event.dart';
part 'state.dart';

class MediaPlayerBloc extends Bloc<MediaPlayerEvent, MediaPlayerState> {
  final AudioPlayer _audioPlayer;

  MediaPlayerBloc({AudioPlayer? audioPlayer})
      : this._audioPlayer = audioPlayer ?? AudioPlayer(),
        super(MediaPlayerInitial());

  @override
  Stream<MediaPlayerState> mapEventToState(MediaPlayerEvent event) async* {
    if (event is MediaPlayerStartListen)
      yield* _mapMediaPlayerStartListenToState(event);

    if (event is MediaPlayerPlay) yield* _mapMediaPlayerPlayToState(event);
    if (event is MediaPlayerPause) yield* _mapMediaPlayerPauseToState(event);
    if (event is MediaPlayerRepeat) yield* _mapMediaPlayerRepeatToState(event);
    if (event is MediaPlayerClose) yield* _mapMediaPlayerCloseToState(event);
  }

  /// This stream hadle if event [MediaPlayerClose] is triggered
  ///

  Stream<MediaPlayerState> _mapMediaPlayerCloseToState(
    MediaPlayerClose event,
  ) async* {
    /// Check if the state is not [MediaPlayerOnListen] and return
    /// and set the state to [MediaPlayerOnListen]
    ///
    if (state is! MediaPlayerOnListen) return;
    MediaPlayerOnListen _state = state as MediaPlayerOnListen;

    _audioPlayer.stop();

    /// return the state to [MediaPlayerOnListen]
    /// and set [showPlayer] to false, it will be close/hide the player
    /// on [MainView].
    ///
    yield _state.copyWith(showPlayer: false);
  }

  /// This stream hadle if event [MediaPlayerRepeat] is triggered
  ///
  Stream<MediaPlayerState> _mapMediaPlayerRepeatToState(
    MediaPlayerRepeat event,
  ) async* {
    _audioPlayer.seek(Duration.zero);
  }

  /// This stream hadle if event [MediaPlayerPause] is triggered
  ///
  Stream<MediaPlayerState> _mapMediaPlayerPauseToState(
    MediaPlayerPause event,
  ) async* {
    _audioPlayer.pause();
  }

  /// This stream hadle if event [MediaPlayerPlay] is triggered
  ///
  Stream<MediaPlayerState> _mapMediaPlayerPlayToState(
    MediaPlayerPlay event,
  ) async* {
    /// Check if the state is not [MediaPlayerOnListen] and return
    /// and set the state to [MediaPlayerOnListen]
    ///
    if (state is! MediaPlayerOnListen) return;
    MediaPlayerOnListen _state = state as MediaPlayerOnListen;

    /// Check if the audio player is already playing
    /// no need to set Url again, just pause and play
    ///
    if (event.processingState != ProcessingState.ready)
      _audioPlayer.setUrl(event.playMusic?.previewUrl ?? '');
    _audioPlayer.play();

    /// return [MediaPlayerOnListen] with the new state
    ///
    yield _state.copyWith(
      musicPlaying: event.playMusic,
      showPlayer: true,
    );
  }

  /// This stream handle if event [MediaPlayerStartListen] is triggered
  /// and return a [_audioPlayer] into [MediaPlayerOnListen] state.
  ///
  Stream<MediaPlayerState> _mapMediaPlayerStartListenToState(
    MediaPlayerStartListen event,
  ) async* {
    yield MediaPlayerOnListen(audioPlayer: _audioPlayer);
  }
}
