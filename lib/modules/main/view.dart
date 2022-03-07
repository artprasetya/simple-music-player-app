import 'package:flutter/material.dart';
import 'package:simple_music_player_app/modules/main/components/media_player.dart';
import 'package:simple_music_player_app/modules/main/components/music_list.dart';

class MainView extends StatelessWidget {
  final MusicListProps musicListProps;
  final MediaPlayerProps mediaPlayerProps;
  final bool? showMediaPlayer;

  const MainView({
    Key? key,
    required this.musicListProps,
    required this.mediaPlayerProps,
    this.showMediaPlayer = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search and List of music
            MusicListComponent(props: musicListProps),

            // Media player
            if (showMediaPlayer == true)
              MediaPlayerComponent(props: mediaPlayerProps),
          ],
        ),
      ),
    );
  }
}
