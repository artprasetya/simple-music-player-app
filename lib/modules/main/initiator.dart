import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simple_music_player_app/models/result.dart';
import 'package:simple_music_player_app/modules/main/blocs/music_bloc/bloc.dart';

class MainInitiator {
  late Timer? _debounce;
  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;
  late MusicListBloc _musicListBloc;

  init() {
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
    _debounce = Timer.periodic(const Duration(milliseconds: 500), (timer) {});

    _musicListBloc = MusicListBloc();
  }

  dispose() {
    _musicListBloc.close();
    _searchController.dispose();
    _searchFocusNode.dispose();
    _debounce?.cancel();
  }

  /// Paramters
  ///
  TextEditingController get searchController => _searchController;
  FocusNode get searchFocusNode => _searchFocusNode;
  MusicListBloc get musicListBloc => _musicListBloc;

  /// Functions
  ///
  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      _musicListBloc.add(MusicListEventGetData(query: query));
      _searchFocusNode.unfocus();
    });
  }

  void onTapItem(Result result) {
    debugPrint('Tapped ${result}');
  }
}
