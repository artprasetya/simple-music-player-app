import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_music_player_app/modules/main/blocs/music_bloc/bloc.dart';
import 'package:simple_music_player_app/modules/main/components/lists/music_list.dart';
import 'package:simple_music_player_app/modules/main/initiator.dart';
import 'package:simple_music_player_app/modules/main/view.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late MainInitiator _initiator;

  @override
  void initState() {
    _initiator = MainInitiator()..init();
    super.initState();
  }

  @override
  void dispose() {
    _initiator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _initiator.musicListBloc,
      builder: (context, MusicListState state) {
        return MainView(
          musicListProps: MusicListProps(
            isLoading: state is MusicListLoading,
            errorMessage: state is MusicListError ? state.errorMessage : null,
            musicList: state is MusicListLoaded ? state.musics ?? [] : [],
            onSearchChanged: _initiator.onSearchChanged,
            searchController: _initiator.searchController,
            searchFocusNode: _initiator.searchFocusNode,
            onTapItem: _initiator.onTapItem,
          ),
        );
      },
    );
  }
}
