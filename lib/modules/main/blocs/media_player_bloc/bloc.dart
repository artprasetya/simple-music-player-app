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

  Stream<MediaPlayerState> _mapMediaPlayerCloseToState(
    MediaPlayerClose event,
  ) async* {
    if (state is! MediaPlayerOnListen) return;
    MediaPlayerOnListen _state = state as MediaPlayerOnListen;

    _audioPlayer.stop();
    yield _state.copyWith(showPlayer: false);
  }

  Stream<MediaPlayerState> _mapMediaPlayerRepeatToState(
    MediaPlayerRepeat event,
  ) async* {
    _audioPlayer.seek(Duration.zero);
  }

  Stream<MediaPlayerState> _mapMediaPlayerPauseToState(
    MediaPlayerPause event,
  ) async* {
    _audioPlayer.pause();
  }

  Stream<MediaPlayerState> _mapMediaPlayerPlayToState(
    MediaPlayerPlay event,
  ) async* {
    if (state is! MediaPlayerOnListen) return;
    MediaPlayerOnListen _state = state as MediaPlayerOnListen;

    if (event.processingState != ProcessingState.ready)
      _audioPlayer.setUrl(event.playMusic?.previewUrl ?? '');
    _audioPlayer.play();

    yield _state.copyWith(
      musicPlaying: event.playMusic,
      showPlayer: true,
    );
  }

  Stream<MediaPlayerState> _mapMediaPlayerStartListenToState(
    MediaPlayerStartListen event,
  ) async* {
    yield MediaPlayerOnListen(audioPlayer: _audioPlayer);
  }
}
