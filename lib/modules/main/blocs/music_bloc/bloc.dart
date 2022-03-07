import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_music_player_app/models/result.dart';
import 'package:simple_music_player_app/modules/main/services/services.dart';

part 'event.dart';
part 'state.dart';

class MusicListBloc extends Bloc<MusicListEvent, MusicListState> {
  MusicListBloc({MainServices? service})
      : this._service = service ?? MainServices(),
        super(MusicListInitial());

  final MainServices? _service;

  @override
  Stream<MusicListState> mapEventToState(MusicListEvent event) async* {
    if (event is MusicListEventGetData) {
      yield* _mapMusicListEventGetDataToState(event);
    }
  }

  /// This stream hadle if event [MusicListEventGetData] is triggered
  ///
  Stream<MusicListState> _mapMusicListEventGetDataToState(
    MusicListEventGetData event,
  ) async* {
    yield MusicListLoading();

    /// Get data from [MainService]
    /// If success, then yield [MusicListLoaded]
    /// If failed, then yield [MusicListError]
    /// 
    try {
      ResultViewModel? response = await _service?.getData(event.query);
      yield MusicListLoaded(musics: response?.results ?? []);
    } catch (e) {
      yield MusicListError(errorMessage: e.toString());
    }
  }
}
