import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:simple_music_player_app/models/result.dart';
import 'package:simple_music_player_app/modules/main/blocs/media_player_bloc/bloc.dart';
import 'package:simple_music_player_app/modules/main/blocs/music_bloc/bloc.dart';
import 'package:simple_music_player_app/modules/main/components/media_player.dart';
import 'package:simple_music_player_app/modules/main/components/music_list.dart';
import 'package:simple_music_player_app/modules/main/initiator.dart';
import 'package:simple_music_player_app/modules/main/view.dart';

/// [MainPage] is [StatefulWidget] has a responsibility as
/// a bridge between [MainView] and [MainInitiator],
/// where [MusicListProps] and [MediaPlayerProps] will be initialized on [MainPage].
///
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late MainInitiator _initiator;

  @override
  void initState() {
    _initiator = MainInitiator()..init();
    super.initState();
  }

  @override
  void dispose() {
    _initiator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Result? _musicPlaying;
    bool? _showMediaPlayer;

    /// This is [BlocConsumer] which will be used
    /// to listen [MediaPlayerBloc].
    ///
    return BlocConsumer(
      bloc: _initiator.playerBloc,
      listener: (context, MediaPlayerState mpState) {
        if (mpState is MediaPlayerOnListen) {
          _musicPlaying = mpState.musicPlaying;
          _showMediaPlayer = mpState.showPlayer;
        }
      },
      builder: (context, MediaPlayerState mpState) {
        PlayerState? _playerState;
        bool? _isPlaying = false;
        ProcessingState? _processingState;

        /// [StreamBuilder] will be used to Stream the [PlayerState].
        ///
        return StreamBuilder<PlayerState>(
            stream: _initiator.audioPlayer.playerStateStream,
            builder: (context, snapshot) {
              _playerState = snapshot.data;
              _isPlaying = _playerState?.playing ?? false;
              _processingState = _playerState?.processingState;

              /// [BlocBuilder] will be used to listen [MusicListBloc].
              ///
              return BlocBuilder(
                bloc: _initiator.bloc,
                builder: (context, MusicListState state) {
                  return MainView(
                    musicListProps: MusicListProps(
                      onPlayMusicTrackId: _musicPlaying?.trackId,
                      isLoading: state is MusicListLoading,
                      errorMessage:
                          state is MusicListError ? state.errorMessage : null,
                      musicList:
                          state is MusicListLoaded ? state.musics ?? [] : [],
                      onSearchChanged: _initiator.onSearchChanged,
                      searchController: _initiator.searchController,
                      searchFocusNode: _initiator.searchFocusNode,
                      onTapItem: _initiator.onTapItem,
                    ),
                    showMediaPlayer: _showMediaPlayer,
                    mediaPlayerProps: MediaPlayerProps(
                      isPlaying: _isPlaying,
                      processingState: _processingState,
                      result: _musicPlaying,
                      onTapPlayerButton: _initiator.onTapPlayerButton,
                    ),
                  );
                },
              );
            });
      },
    );
  }
}
