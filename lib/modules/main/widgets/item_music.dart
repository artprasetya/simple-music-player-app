import 'package:flutter/material.dart';

/// This is a reusable widget that can be used to display a list of items.
/// It is used in the [MusicListComponent] to display the list of Music items.
///
class ItemMusic extends StatelessWidget {
  final String songName;
  final String artist;
  final String album;
  final String imageUrl;
  final String musicUrl;
  final bool? isPlaying;
  final VoidCallback? onTapMusic;

  const ItemMusic({
    Key? key,
    required this.songName,
    required this.artist,
    required this.album,
    required this.imageUrl,
    required this.musicUrl,
    this.isPlaying = false,
    this.onTapMusic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // This widget will show the image of the song
              Image.network(
                imageUrl,
                width: 100,
              ),
              const SizedBox(width: 16),

              // This widget will show the detail of the song
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Song Name
                    Text(
                      songName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Artist Name
                    Text(
                      artist,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 4),

                    // Album Name
                    Text(
                      album,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),

              // This widget will show if the song is playing or not
              if (isPlaying == true) ...[
                const SizedBox(width: 16),
                const Icon(
                  Icons.play_arrow_sharp,
                  color: Colors.green,
                ),
              ],
            ],
          ),
        ),
        onTap: onTapMusic,
      ),
    );
  }
}
