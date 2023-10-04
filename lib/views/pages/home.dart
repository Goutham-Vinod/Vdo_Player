import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vdo_player/controllers/common_Provider.dart';
import 'package:vdo_player/widgets/grid_list_view_videos_widget.dart';
import 'package:vdo_player/controllers/common_functions.dart';

import '../screens/video_player/video_player.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CommonVariablesNotifier>(
      builder: (context, commonVariable, child) {
        List<String> videos = findUniqueFiles(commonVariable.videosGlobal);
        return GridListViewVideosWidget(
          dataList: videos,
          onTapFunction: (index) {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
              return VideoPreview(videoPaths: videos,startIndex: index,);
            }));
          },
          enableThreeDot: true,
        );
      },
    );
  }
}
