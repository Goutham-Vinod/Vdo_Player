import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vdo_player/widgets/grid_list_view_videos_widget.dart';
import 'package:vdo_player/controllers/common_functions.dart';
import 'package:vdo_player/widgets/sort_popup_button.dart';
import 'package:vdo_player/controllers/common_Provider.dart';

import '../screens/video_player/video_player.dart';

class FolderVideos extends StatelessWidget {
  FolderVideos({super.key});

  final List videosGlobalBackup = [];
  final bool searchTextControllerVisibility = false;

  @override
  Widget build(BuildContext context) {
    CommonVariablesNotifier commonVariablesNotifieProvider =
        Provider.of<CommonVariablesNotifier>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Folder videos"),
          actions: [
            Consumer<CommonVariablesNotifier>(
              builder: (context, commonVariables, child) => IconButton(
                  onPressed: () {
                    commonVariables.gridViewState == 1
                        ? commonVariablesNotifieProvider.gridViewState = 0
                        : commonVariablesNotifieProvider.gridViewState = 1;
                  },
                  icon: commonVariables.gridViewState == 1
                      ? const Icon(Icons.list)
                      : const Icon(Icons.grid_view_outlined)),
            ),
            sortPopupButton(context),
          ],
        ),
        body: Column(
          children: [
            Expanded(child: Consumer<CommonVariablesNotifier>(
              builder: (context, commonVariables, child) {
                List videos = findUniqueFiles(searchFromStringList(
                    selectedFolderPath,
                    commonVariablesNotifieProvider.videosGlobal));
                return GridListViewVideosWidget(
                  dataList: videos,
                  onTapFunction: (index) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      return VideoPreview(videos[index]);
                    }));
                  },
                  enableThreeDot: true,
                  enableDeleteAtThreeDot: false,
                );
              },
            ))
          ],
        ));
  }
}
