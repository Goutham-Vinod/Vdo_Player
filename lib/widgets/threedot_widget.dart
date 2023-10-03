import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vdo_player/controllers/db_functions.dart';
import 'package:vdo_player/widgets/create_playlist_dialogue.dart';

class ThreeDot extends StatelessWidget {
  ThreeDot(
      {this.videoPath,
      required this.enableDelete,
      this.deleteFunction,
      this.index,
      super.key});
  final String? videoPath;
  final bool? enableDelete;
  final Function? deleteFunction;
  final int?
      index; // index is mandatory for the proper working of delete function
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.more_vert,
        size: 20,
      ),
      itemBuilder: (context) {
        List<PopupMenuItem<String>> popupMenuItemList = [
          PopupMenuItem(value: "Favourite", child: Text("Add to Favourite")),
          PopupMenuItem(value: "Playlist", child: Text("Add to Playlist")),
          // PopupMenuItem(value: "Share", child: Text("Share"))
        ];
        if (enableDelete == true) {
          popupMenuItemList
              .add(PopupMenuItem(value: "Delete", child: Text("Delete")));
        }
        return popupMenuItemList;
      },
      onSelected: (String? value) {
        if (value != null) {
          switch (value) {
            case "Favourite":
              if (videoPath != null) {
                Provider.of<DbNotifier>(context, listen: false)
                    .addToPlaylist(videoPath!, 0);
              }
              break;
            case "Playlist":
              //debugPrint("Playlist Selected");
              //selectedNaviBarIndexNotifierGlobal.value = 2;
              showAddToPlaylistBox(context);
              break;
            case "Delete":
              if (deleteFunction != null) {
                deleteFunction!(index);
              }
              break;
            case "Share":
              //print("Share Selected");
              break;
            default:
              //print("Nothing Selected");
              break;
          }
        }
      },
    );
  }

  dynamic showAddToPlaylistBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            titlePadding: EdgeInsets.zero,
            title: Container(
              color: Colors.purple,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Add to playlist",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        onPressed: () {
                          showCreatePlaylistDialog(context);
                        },
                        icon: Icon(
                          Icons.add_box_outlined,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            ),
            content: SizedBox(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width / 2.5,
                child: Consumer<DbNotifier>(builder: (context, db, child) {
                  return ListView.builder(
                    itemCount: db.playlistFolders.length,
                    itemBuilder: (_, i) {
                      return InkWell(
                        onTap: () {
                          if (db.playlistFolders[i].id != null) {
                            if (videoPath != null) {
                              Provider.of<DbNotifier>(context, listen: false)
                                  .addToPlaylist(videoPath!, i);
                            }
                            print("${db.playlistFolders[i].id} added");
                          } else {
                            print(
                                "Null detected at playlistFolderNotifier.value[i].id");
                          }
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(48, 155, 39, 176),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  border: Border.all(
                                      color:
                                          Color.fromARGB(255, 180, 68, 255))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(db.playlistFolders[i].playlistName),
                              )),
                        ),
                      );
                    },
                  );
                })),
          );
        });
  }
}
