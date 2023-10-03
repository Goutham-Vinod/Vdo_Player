import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vdo_player/widgets/grid_list_view_videos_widget.dart';
import 'package:vdo_player/controllers/common_Provider.dart';
import 'package:vdo_player/controllers/db_functions.dart';

import '../screens/video_player/video_player.dart';


class PlaylistVideos extends StatelessWidget {
  const PlaylistVideos({super.key});

  @override
  Widget build(BuildContext context) {
    CommonVariablesNotifier commonVariablesNotifieProvider =
        Provider.of<CommonVariablesNotifier>(context, listen: false);

    DbNotifier dbNotifieProvider =
        Provider.of<DbNotifier>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Playlist Videos"),
          actions: [
            Consumer<CommonVariablesNotifier>(
              builder: (context, commonVariables, child) => IconButton(
                  onPressed: () {
                    // setState(() {
                    commonVariables.gridViewState == 1
                        ? commonVariablesNotifieProvider.gridViewState = 0
                        : commonVariablesNotifieProvider.gridViewState = 1;
                    // });
                  },
                  icon: commonVariables.gridViewState == 1
                      ? const Icon(Icons.list)
                      : const Icon(Icons.grid_view_outlined)),
            ),
          ],
        ),
        body: Consumer<DbNotifier>(builder: (context, Db, child) {
          if (Db.playlistFolders[selectedPlaylistFolderIndex].playlist !=
              null) {
              
            return GridListViewVideosWidget(
              dataList:
                  Db.playlistFolders[selectedPlaylistFolderIndex].playlist!,
              onTapFunction: (index) {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return VideoPreview(Db
                      .playlistFolders[selectedPlaylistFolderIndex]
                      .playlist![index]);
                }));
              },
              enableThreeDot: true,
              enableDeleteAtThreeDot: true,
              deleteFunction: (index) {
                dbNotifieProvider
                    .playlistFolders[selectedPlaylistFolderIndex].playlist
                    ?.removeAt(index);
                Provider.of<DbNotifier>(context, listen: false).updatePlaylist(
                    dbNotifieProvider
                        .playlistFolders[selectedPlaylistFolderIndex]);
              },
            );
          } else {
            return const Center(child: Text("No Videos"));
          }
        }));
  }
}
