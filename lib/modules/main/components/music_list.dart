import 'package:flutter/material.dart';
import 'package:simple_music_player_app/models/result.dart';
import 'package:simple_music_player_app/modules/main/widgets/item_music.dart';

class MusicListProps {
  final bool? isLoading;
  final String? errorMessage;
  final List<Result> musicList;
  final TextEditingController searchController;
  final FocusNode searchFocusNode;
  final int? onPlayMusicTrackId;
  final Function(String) onSearchChanged;
  final Function(Result) onTapItem;

  MusicListProps({
    this.isLoading = false,
    this.errorMessage,
    this.onPlayMusicTrackId,
    required this.musicList,
    required this.searchController,
    required this.searchFocusNode,
    required this.onSearchChanged,
    required this.onTapItem,
  });
}

class MusicListComponent extends StatelessWidget {
  final MusicListProps props;

  const MusicListComponent({
    Key? key,
    required this.props,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // SearchBar,
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: props.searchController,
              focusNode: props.searchFocusNode,
              onChanged: props.onSearchChanged,
              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(12.0),
                hintText: 'Search by Artist',
              ),
            ),
          ),

          if (props.isLoading == true)
            Expanded(child: Center(child: CircularProgressIndicator())),

          if (props.errorMessage != null)
            Expanded(child: Center(child: Text(props.errorMessage!))),

          if (props.musicList.isEmpty && props.isLoading == false)
            Expanded(child: Center(child: Text('No music found'))),

          // List of music
          if (props.musicList.isNotEmpty)
            Expanded(
              child: SingleChildScrollView(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: props.musicList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Result music = props.musicList[index];
                    return ItemMusic(
                      key: ValueKey('item_music_${music.trackId}'),
                      songName: music.trackName ?? 'Unknown',
                      artist: music.artistName ?? 'Unknown',
                      album: music.collectionName ?? 'Unknown',
                      imageUrl: music.artworkUrl100 ??
                          'https://via.placeholder.com/100x100',
                      musicUrl: '',
                      isPlaying: music.trackId == props.onPlayMusicTrackId,
                      onTapMusic: () {
                        props.onTapItem(props.musicList[index]);
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(height: 1),
                ),
              ),
            )
        ],
      ),
    );
  }
}
