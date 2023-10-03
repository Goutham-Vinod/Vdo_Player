import 'package:flutter/material.dart';
import 'package:vdo_player/models/db_models/db_model.dart';
import 'package:hive/hive.dart';

class DbNotifier with ChangeNotifier {
  // List<PlaylistModel> playlistFolders = [];

  List<PlaylistModel> _playlistFolders = [];

  set playlistFolders(val) {
    _playlistFolders = val;
  }

  get playlistFolders => _playlistFolders;

  Future<void> addPlaylist(PlaylistModel value) async {
    final videoDB = await Hive.openBox<PlaylistModel>('video_db');
    final id = await videoDB.add(value);
    value.id = id;

    await videoDB.put(id, value);
    getAllPlaylist();
  }

  Future<void> getAllPlaylist() async {
    final videoDB = await Hive.openBox<PlaylistModel>('video_db');
    playlistFolders.clear();
    playlistFolders.addAll(videoDB.values);
    notifyListeners();
  }

  Future<void> deletePlaylist(int id) async {
    final videoDB = await Hive.openBox<PlaylistModel>('video_db');
    await videoDB.delete(id);
    getAllPlaylist();
  }

  Future<void> updatePlaylist(PlaylistModel data) async {
    final videoDB = await Hive.openBox<PlaylistModel>('video_db');
    await videoDB.put(data.id, data);
    getAllPlaylist();
  }

  Future<void> addToPlaylist(String videoPath, int playlistId) async {
    getAllPlaylist();

    PlaylistModel currentPlaylistData = PlaylistModel(
        id: playlistFolders[playlistId].id,
        playlistName: playlistFolders[playlistId].playlistName,
        playlist: playlistFolders[playlistId].playlist);

    currentPlaylistData.playlist ??= [];
    currentPlaylistData.playlist!.add(videoPath);

    updatePlaylist(currentPlaylistData);
    getAllPlaylist();
  }

  Future<void> clearVideosInPlaylist(int playlistId) async {
    getAllPlaylist();
    PlaylistModel currentPlaylistData = PlaylistModel(
        id: playlistFolders[playlistId].id,
        playlistName: playlistFolders[playlistId].playlistName,
        playlist: []);
    updatePlaylist(currentPlaylistData);
    getAllPlaylist();
  }

  Future addDefaultsToDb() async {
    final videoDB = await Hive.openBox<PlaylistModel>('video_db');

    getAllPlaylist();
    if (videoDB.isEmpty) {
      final data = PlaylistModel(playlistName: "Favourites");
      addPlaylist(data);
    }
  }

  Future<void> closePlaylistDb() async {
    await Hive.close();
  }

  Future<void> clearPlaylistDb() async {
    final videoDB = await Hive.openBox<PlaylistModel>('video_db');
    await videoDB.clear();
    addDefaultsToDb();
    getAllPlaylist();
  }
}
