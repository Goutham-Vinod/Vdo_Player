import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vdo_player/controllers/db_functions.dart';
import 'package:vdo_player/views/pages/playlist_videos.dart';
import 'package:vdo_player/controllers/common_functions.dart';
import 'package:vdo_player/controllers/common_Provider.dart';

class Playlist extends StatelessWidget {
  Playlist({super.key});

  final _listKey = GlobalKey();
  // double userTapPosX = 0;
  // double userTapPosY = 0;

  @override
  Widget build(BuildContext context) {
    CommonVariablesNotifier commonVariablesNotifieProvider =
        Provider.of<CommonVariablesNotifier>(context, listen: false);
    return Consumer<CommonVariablesNotifier>(
      
        builder: (context, commonVariables, child) {
      return Consumer<DbNotifier>(builder: (context, db, child) {
        return commonVariables.gridViewState == 1
            ? GridView.builder(
                itemCount: db.playlistFolders.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 1),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTapDown: (details) {
                      commonVariablesNotifieProvider.userTapPosX =
                          details.globalPosition.dx;
                      commonVariablesNotifieProvider.userTapPosY =
                          details.globalPosition.dy;
                    },
                    onLongPress: () {
                      showPopUpMenu(
                          context,
                          db.playlistFolders[index].id,
                          commonVariables.userTapPosX,
                          commonVariables.userTapPosY);
                    },
                    onTap: () {
                      selectedPlaylistFolderIndex = index;
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) {
                        return const PlaylistVideos();
                      }));
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Image.asset(
                            "assets/playlist_thumbnail_icon.png",
                            height: 50,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 67,
                          child: Text(
                            truncateWithEllipsis(
                                25, db.playlistFolders[index].playlistName),
                            style: const TextStyle(fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  );
                })
            : Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: ListView.separated(
                    key: _listKey,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTapDown: (details) {
                          commonVariablesNotifieProvider.userTapPosX =
                              details.globalPosition.dx;
                          commonVariablesNotifieProvider.userTapPosY =
                              details.globalPosition.dy;
                        },
                        onLongPress: () {
                          showPopUpMenu(
                              context,
                              db.playlistFolders[index].id,
                              commonVariablesNotifieProvider.userTapPosX,
                              commonVariablesNotifieProvider.userTapPosY);
                        },
                        onTap: () {
                          selectedPlaylistFolderIndex = index;
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return const PlaylistVideos();
                          }));
                        },
                        child: ListTile(
                          leading: const Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Image(
                                image: AssetImage(
                                    "assets/playlist_thumbnail_icon.png")),
                          ),
                          title: Text(
                            truncateWithEllipsis(
                                25, db.playlistFolders[index].playlistName),
                          ),
                        ),
                      );
                    },
                    itemCount: db.playlistFolders.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(thickness: 1)),
              );
      });
    });
  }

  void showPopUpMenu(BuildContext context, playlistId, posX, posY) {
    showMenu(
        context: context,
        position: RelativeRect.fromLTRB(posX, posY, posX, posY),
        items: [
          const PopupMenuItem(value: "Delete", child: Text("Delete")),
        ]).then((value) {
      if (value != null) {
        if (value == "Delete") {
          if (playlistId != null && playlistId != 0) {
            // playlist id == 0 should not be deleted
            //because it will be favourites playlist
            Provider.of<DbNotifier>(context, listen: false)
                .deletePlaylist(playlistId!);
          }
          if (playlistId == 0) {
            Provider.of<DbNotifier>(context, listen: false)
                .clearVideosInPlaylist(playlistId);
          }
        }
        if (value == "Clear Playlist") {
          Provider.of<DbNotifier>(context, listen: false)
              .clearVideosInPlaylist(playlistId);
        }
      }
    });
  }
}
