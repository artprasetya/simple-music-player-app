import 'dart:convert';

ResultViewModel? resultViewModelFromJson(String? str) {
  if (str == null) return null;
  return ResultViewModel.fromJson(json.decode(str));
}

class ResultViewModel {
  ResultViewModel({
    this.resultCount,
    this.results,
  });

  final int? resultCount;
  final List<Result>? results;

  static ResultViewModel? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return ResultViewModel(
      resultCount: json["resultCount"],
      results: Result.parseList(json["results"]),
    );
  }
}

class Result {
  Result({
    this.wrapperType,
    this.kind,
    this.artistId,
    this.collectionId,
    this.trackId,
    this.artistName,
    this.collectionName,
    this.trackName,
    this.collectionCensoredName,
    this.trackCensoredName,
    this.artistViewUrl,
    this.collectionViewUrl,
    this.trackViewUrl,
    this.previewUrl,
    this.artworkUrl30,
    this.artworkUrl60,
    this.artworkUrl100,
    this.collectionPrice,
    this.trackPrice,
    this.releaseDate,
    this.collectionExplicitness,
    this.trackExplicitness,
    this.discCount,
    this.discNumber,
    this.trackCount,
    this.trackNumber,
    this.trackTimeMillis,
    this.country,
    this.currency,
    this.primaryGenreName,
    this.isStreamable,
    this.collectionArtistName,
  });

  final String? wrapperType;
  final String? kind;
  final int? artistId;
  final int? collectionId;
  final int? trackId;
  final String? artistName;
  final String? collectionName;
  final String? trackName;
  final String? collectionCensoredName;
  final String? trackCensoredName;
  final String? artistViewUrl;
  final String? collectionViewUrl;
  final String? trackViewUrl;
  final String? previewUrl;
  final String? artworkUrl30;
  final String? artworkUrl60;
  final String? artworkUrl100;
  final double? collectionPrice;
  final double? trackPrice;
  final String? releaseDate;
  final String? collectionExplicitness;
  final String? trackExplicitness;
  final int? discCount;
  final int? discNumber;
  final int? trackCount;
  final int? trackNumber;
  final int? trackTimeMillis;
  final String? country;
  final String? currency;
  final String? primaryGenreName;
  final bool? isStreamable;
  final String? collectionArtistName;

  static List<Result> parseList(List<dynamic>? response) {
    return (response != null)
        ? List<Result>.from(response.map((r) => Result.fromJson(r as dynamic)))
        : [];
  }

  static Result? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return Result(
      wrapperType: json["wrapperType"],
      kind: json["kind"],
      artistId: json["artistId"],
      collectionId: json["collectionId"],
      trackId: json["trackId"],
      artistName: json["artistName"],
      collectionName: json["collectionName"],
      trackName: json["trackName"],
      collectionCensoredName: json["collectionCensoredName"],
      trackCensoredName: json["trackCensoredName"],
      artistViewUrl: json["artistViewUrl"],
      collectionViewUrl: json["collectionViewUrl"],
      trackViewUrl: json["trackViewUrl"],
      previewUrl: json["previewUrl"],
      artworkUrl30: json["artworkUrl30"],
      artworkUrl60: json["artworkUrl60"],
      artworkUrl100: json["artworkUrl100"],
      collectionPrice: json["collectionPrice"].toDouble(),
      trackPrice: json["trackPrice"].toDouble(),
      releaseDate: json["releaseDate"],
      collectionExplicitness: json["collectionExplicitness"],
      trackExplicitness: json["trackExplicitness"],
      discCount: json["discCount"],
      discNumber: json["discNumber"],
      trackCount: json["trackCount"],
      trackNumber: json["trackNumber"],
      trackTimeMillis: json["trackTimeMillis"],
      country: json["country"],
      currency: json["currency"],
      primaryGenreName: json["primaryGenreName"],
      isStreamable: json["isStreamable"] == null ? null : json["isStreamable"],
      collectionArtistName: json["collectionArtistName"] == null
          ? null
          : json["collectionArtistName"],
    );
  }
}
