import 'package:hive/hive.dart';

part 'db_model.g.dart';

@HiveType(typeId: 0)
class PlaylistModel extends HiveObject {
  PlaylistModel({this.id, required this.playlistName, this.playlist});

  @HiveField(0)
  late int? id;

  @HiveField(1)
  late String playlistName;

  @HiveField(2)
  late List<String>? playlist;
}
