import 'package:flutter/material.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';

enum AsyncState { loading, success, error }

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;
  List<Song>? _songs;
  AsyncState state = AsyncState.loading;

  LibraryViewModel({required this.songRepository, required this.playerState}) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  List<Song> get songs => _songs == null ? [] : _songs!;

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    state = AsyncState.loading;
    // 1 - Fetch songs
    try {
     _songs = await songRepository.fetchSongs();
      state = AsyncState.success;
    } catch (e) {
      // 5. Catch error
      state = AsyncState.error;
    }

    // 2 - notify listeners
    notifyListeners();
  }
  

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}
