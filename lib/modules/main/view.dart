import 'package:flutter/material.dart';
import 'package:simple_music_player_app/modules/main/components/lists/music_list.dart';

class MainView extends StatelessWidget {
  final MusicListProps musicListProps;

  const MainView({
    Key? key,
    required this.musicListProps,
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

            // Music player
          ],
        ),
      ),
    );
  }
}
