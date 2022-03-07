import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:simple_music_player_app/models/result.dart';
import 'package:simple_music_player_app/modules/main/blocs/media_player_bloc/bloc.dart';
import 'package:simple_music_player_app/modules/main/blocs/music_bloc/bloc.dart';

class MainInitiator {
  late Timer? _debounce;
  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;
  late AudioPlayer _audioPlayer;
  late MusicListBloc _bloc;
  late MediaPlayerBloc _playerBloc;

  init() {
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();

    _debounce = Timer.periodic(const Duration(milliseconds: 500), (timer) {});

    _audioPlayer = AudioPlayer();
    _audioPlayer.setVolume(100);

    _bloc = MusicListBloc();
    _playerBloc = MediaPlayerBloc(audioPlayer: _audioPlayer);
    _playerBloc.add(MediaPlayerStartListen());
  }

  dispose() {
    _bloc.close();
    _playerBloc.close();
    _searchController.dispose();
    _searchFocusNode.dispose();
    _debounce?.cancel();
    _audioPlayer.dispose();
  }

  /// Paramters
  ///
  MusicListBloc get bloc => _bloc;
  MediaPlayerBloc get playerBloc => _playerBloc;
  TextEditingController get searchController => _searchController;
  FocusNode get searchFocusNode => _searchFocusNode;
  AudioPlayer get audioPlayer => _audioPlayer;

  /// Functions
  ///
  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      final playerState = _audioPlayer.playerState;
      if (playerState.playing != true ||
          playerState.processingState == ProcessingState.completed)
        _playerBloc.add(MediaPlayerClose());

      _bloc.add(MusicListEventGetData(query: query));
      _searchFocusNode.unfocus();
    });
  }

  void onTapItem(Result result) =>
      _playerBloc.add(MediaPlayerPlay(playMusic: result));

  void onTapPlayerButton() {
    if (_playerBloc.state is! MediaPlayerOnListen) return;
    MediaPlayerOnListen _state = _playerBloc.state as MediaPlayerOnListen;

    final playerState = _audioPlayer.playerState;

    if (playerState.playing != true) {
      _playerBloc.add(MediaPlayerPlay(
        playMusic: _state.musicPlaying,
        processingState: playerState.processingState,
      ));
    } else if (playerState.processingState != ProcessingState.completed) {
      _playerBloc.add(MediaPlayerPause());
    } else {
      _playerBloc.add(MediaPlayerRepeat());
    }
  }
}
