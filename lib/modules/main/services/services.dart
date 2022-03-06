import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_music_player_app/helper/helper.dart';
import 'package:simple_music_player_app/models/result.dart';

class MainServices {
  // This service is responsible for getting the data from the server
  final String _endpoint = "https://itunes.apple.com/search";
  final Dio _dio = Dio();

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
