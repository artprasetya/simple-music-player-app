import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Helper {
  /// This method [replaceSpace] is used to replace space character
  /// with plus character on String [query].
  ///
  /// For Example: The query is "Hello World"
  /// And the result will be "Hello+World".
  ///
  /// How to use: just call this method
  /// like replace('Hello World').
  ///
  static String? replaceSpace(String? query) {
    if (query == null) return null;
    return query.trim().replaceAll(" ", "+");
  }

  /// The [genereateIcon] is used to generate [Widget] depending on the
  /// [ProcessingState] and [isPlaying]. 
  /// 
  /// For Example: If the [ProcessingState] is not [ProcessingState.completed]
  /// will return [IconButton] with [Icons.pause] icon.
  /// 
  static Widget generateIcon({
    bool? isPlaying = false,
    ProcessingState? processingState,
    VoidCallback? onTap,
  }) {
    if (processingState == ProcessingState.loading ||
        processingState == ProcessingState.buffering) {
      return Container(
        margin: EdgeInsets.all(8),
        child: CircularProgressIndicator(),
      );
    } else if (isPlaying != true) {
      return IconButton(
        key: ValueKey('media-player-play-button'),
        icon: Icon(Icons.play_arrow),
        iconSize: 32,
        onPressed: onTap,
      );
    } else if (processingState != ProcessingState.completed) {
      return IconButton(
        key: ValueKey('media-player-pause-button'),
        icon: Icon(Icons.pause),
        iconSize: 32,
        onPressed: onTap,
      );
    } else {
      return IconButton(
        key: ValueKey('media-player-repeat-button'),
        icon: Icon(Icons.replay),
        iconSize: 32,
        onPressed: onTap,
      );
    }
  }
}
