import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vdo_player/controllers/get_all_videos.dart';
import '../views/screens/home_screen.dart';
import 'common_Provider.dart';
import 'db_functions.dart';

Future<void> splashScreenFunctions(context) async {
  // await Future.delayed(const Duration(seconds: 3));
  // FetchAllVideos ob = FetchAllVideos();
  Provider.of<CommonVariablesNotifier>(context, listen: false).videosGlobal =
      await FetchAllVideos().getAllVideos();

  Provider.of<DbNotifier>(context, listen: false).addDefaultsToDb();
  Provider.of<CommonVariablesNotifier>(context, listen: false)
      .selectedNaviBarIndex = 0;
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
    return HomeScreen();
  }));
}
