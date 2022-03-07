import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_music_player_app/helper/helper.dart';
import 'package:simple_music_player_app/models/result.dart';

class MainServices {
  /// Initialize the Dio object and endpoint;
  final String _endpoint = "https://itunes.apple.com/search";
  final Dio _dio = Dio();

  /// This is the function that will be used to fetch the data from the API
  /// It will return a [ResultViewModel] object.
  ///
  Future<ResultViewModel?> getData(String? query) async {
    try {
      Response response = await _dio.get(
        _endpoint,
        queryParameters: {
          "term": Helper.replaceSpace(query),
          "entity": "musicTrack",
          "attribute": "artistTerm",
        },
      );
      return resultViewModelFromJson(response.data);
    } catch (error, stacktrace) {
      debugPrint("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }
}
