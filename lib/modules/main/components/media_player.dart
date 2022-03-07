import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:simple_music_player_app/helper/helper.dart';
import 'package:simple_music_player_app/models/result.dart';

class MediaPlayerProps {
  final AudioPlayer? audioPlayer;
  final bool? isPlaying;
  final ProcessingState? processingState;
  final Result? result;
  final VoidCallback? onTapPlayerButton;

  MediaPlayerProps({
    this.audioPlayer,
    this.result,
    this.onTapPlayerButton,
    this.isPlaying = false,
    this.processingState,
  });
}

class MediaPlayerComponent extends StatelessWidget {
  final MediaPlayerProps props;

  const MediaPlayerComponent({
    Key? key,
    required this.props,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[400]),
      padding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Music Details
          Container(
            child: Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Artwork
                  Container(
                    width: 60,
                    child: Image.network(
                      props.result?.artworkUrl100 ?? '',
                      width: 60,
                      errorBuilder: (context, error, stackTrace) =>
                          Center(child: Icon(Icons.image, size: 60)),
                    ),
                  ),
                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Artist Name
                        Text(
                          props.result?.artistName ?? '',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 4),

                        // Song Name
                        Text(
                          props.result?.trackName ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Player Button
          Helper.generateIcon(
            isPlaying: props.isPlaying,
            processingState: props.processingState,
            onTap: props.onTapPlayerButton,
          ),
        ],
      ),
    );
  }
}
