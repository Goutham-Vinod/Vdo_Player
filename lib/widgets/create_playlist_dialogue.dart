import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vdo_player/models/db_models/db_model.dart';

import '../controllers/db_functions.dart';

Future showCreatePlaylistDialog(context) async {
  TextEditingController controller = TextEditingController();
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Create Playlist"),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: "Enter Playlist Name"),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: Text("Create"),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                final playlist = PlaylistModel(playlistName: controller.text);
                Provider.of<DbNotifier>(context, listen: false)
                    .addPlaylist(playlist);
              }
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
