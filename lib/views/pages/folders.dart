import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vdo_player/widgets/grid_list_view_folders_widget.dart';
import 'package:vdo_player/views/pages/folder_videos.dart';
import 'package:vdo_player/controllers/common_Provider.dart';

class Folders extends StatelessWidget {
  const Folders({super.key});

  @override
  Widget build(BuildContext context) {
    CommonVariablesNotifier commonVariablesNotifierProvider =
        Provider.of<CommonVariablesNotifier>(context, listen: false);
    return GridListViewFoldersWidget(
      dataList: commonVariablesNotifierProvider.uniqueFolders,
      thumbnailImage: Image.asset("assets/folder_thumbnail_icon.png"),
      onTapFunction: (index) {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return FolderVideos();
        }));
        selectedFolderPath =
            commonVariablesNotifierProvider.uniqueFolders[index];
      },
    );
  }
}
