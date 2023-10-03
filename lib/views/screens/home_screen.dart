import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vdo_player/controllers/common_functions.dart';
import 'package:vdo_player/widgets/create_playlist_dialogue.dart';
import 'package:vdo_player/widgets/dialog_box_widget.dart';
import 'package:vdo_player/widgets/show_snack_bar.dart';
import 'package:vdo_player/controllers/db_functions.dart';
import 'package:vdo_player/views/pages/settings.dart';
import 'package:vdo_player/controllers/common_Provider.dart';
import 'package:vdo_player/views/pages/folders.dart';
import 'package:vdo_player/views/pages/home.dart';
import 'package:vdo_player/views/pages/playlist.dart';
import 'package:vdo_player/widgets/sort_popup_button.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  int currentNaviIndex = 0;
  String appBarTitle = "Vdo Player";
  bool appBarTitleCenterToggle = false;
  bool appBarSearchIconVisibility = true;
  bool playlistPageIconVisibility = false;
  bool appBarSortIconVisibility = true;
  bool appBarGridIconVisibility = true;
  final _searchTextController = TextEditingController();
  List videosGlobalBackup = [];

  List pages = <Widget>[
    const Home(),
    const Folders(),
    Playlist(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    CommonVariablesNotifier commonVariablesNotifierProvider =
        Provider.of<CommonVariablesNotifier>(context, listen: false);
    videosGlobalBackup = commonVariablesNotifierProvider.videosGlobal;
    return Consumer<CommonVariablesNotifier>(
        builder: (context, commonVariables, child) {
      if (commonVariables.selectedNaviBarIndex < 4) {
        currentNaviIndex = commonVariables.selectedNaviBarIndex;
      }
      return Scaffold(
          appBar: AppBar(
            title: Text(appBarTitle),
            centerTitle: appBarTitleCenterToggle,
            actions: [
              Visibility(
                visible: appBarGridIconVisibility,
                child: Consumer<CommonVariablesNotifier>(
                  builder: (context, commonVariables, child) => IconButton(
                      onPressed: () {
                        commonVariables.gridViewState == 1
                            ? commonVariablesNotifierProvider.gridViewState = 0
                            : commonVariablesNotifierProvider.gridViewState = 1;
                      },
                      icon: commonVariables.gridViewState == 1
                          ? const Icon(Icons.list)
                          : const Icon(Icons.grid_view_outlined)),
                ),
              ),
              Visibility(
                  visible: appBarSortIconVisibility,
                  child: sortPopupButton(context)),
              Visibility(
                  visible: appBarSearchIconVisibility,
                  child: IconButton(
                      onPressed: () {
                        commonVariablesNotifierProvider
                            .searchTextControllerVisibility = true;
                      },
                      icon: const Icon(Icons.search))),
              Visibility(
                  visible: playlistPageIconVisibility,
                  child: IconButton(
                      onPressed: () {
                        dialogBoxWidget(
                            context,
                            "Delete All Playlist",
                            "Are you sure you want to delete all playlist permanently?",
                            "Delete", () {
                          Provider.of<DbNotifier>(context, listen: false)
                              .clearPlaylistDb();
                          showSnackBar(
                              context, "All Playlist deleted permanently");
                          Navigator.of(context).pop();
                        });
                      },
                      icon: const Icon(Icons.delete_forever))),
              Visibility(
                  visible: playlistPageIconVisibility,
                  child: IconButton(
                      onPressed: () {
                        showCreatePlaylistDialog(context);
                      },
                      icon: const Icon(Icons.add_box_outlined))),
            ],
          ),
          body: Column(
            children: [
              Consumer<CommonVariablesNotifier>(
                builder: (context, commonVariables, child) {
                  return Visibility(
                    visible: commonVariables.searchTextControllerVisibility,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: _searchTextController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Search',
                          suffixIcon: IconButton(
                              onPressed: () {
                                commonVariables.searchTextControllerVisibility =
                                    false;
                                commonVariablesNotifierProvider.videosGlobal =
                                    videosGlobalBackup;
                              },
                              icon: const Icon(Icons.clear)),
                        ),
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) {},
                        onChanged: (value) {
                          if (videosGlobalBackup.isEmpty) {
                            videosGlobalBackup =
                                commonVariablesNotifierProvider.videosGlobal;
                          }

                          commonVariablesNotifierProvider.videosGlobal =
                              searchFromStringList(value, videosGlobalBackup);

                          if (value == "") {
                            commonVariablesNotifierProvider.videosGlobal =
                                videosGlobalBackup;
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
              Consumer<CommonVariablesNotifier>(
                builder: (context, commonVariables, child) {
                  return Expanded(
                      child: pages[commonVariables.selectedNaviBarIndex]);
                },
              )
            ],
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 155, 155, 155), blurRadius: 20)
            ]),
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 30,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.folder,
                    size: 30,
                  ),
                  label: 'Folders',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.playlist_add,
                    size: 30,
                  ),
                  label: 'Playlist',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    size: 30,
                  ),
                  label: 'Settings',
                ),
              ],
              currentIndex: currentNaviIndex,
              selectedItemColor: const Color.fromARGB(250, 61, 0, 121),
              onTap: (value) {
                Provider.of<CommonVariablesNotifier>(context, listen: false)
                    .selectedNaviBarIndex = value;
                commonVariablesNotifierProvider.videosGlobal =
                    videosGlobalBackup;
                switch (value) {
                  case 0:
                    appBarTitle = "Vdo Player";
                    appBarSortIconVisibility = true;
                    appBarTitleCenterToggle = false;
                    appBarSearchIconVisibility = true;
                    playlistPageIconVisibility = false;
                    appBarGridIconVisibility = true;
                    break;
                  case 1:
                    appBarTitle = "Folders";
                    appBarSortIconVisibility = false;
                    appBarTitleCenterToggle = false;
                    appBarSearchIconVisibility = false;
                    playlistPageIconVisibility = false;
                    appBarGridIconVisibility = true;
                    commonVariablesNotifierProvider
                        .searchTextControllerVisibility = false;

                    break;
                  case 2:
                    appBarTitle = "Playlist";
                    appBarSortIconVisibility = false;
                    appBarTitleCenterToggle = false;
                    appBarSearchIconVisibility = false;
                    playlistPageIconVisibility = true;
                    appBarGridIconVisibility = true;
                    commonVariablesNotifierProvider
                        .searchTextControllerVisibility = false;

                    break;
                  case 3:
                    appBarTitle = "Settings";
                    appBarSortIconVisibility = false;
                    appBarTitleCenterToggle = true;
                    appBarSearchIconVisibility = false;
                    playlistPageIconVisibility = false;
                    appBarGridIconVisibility = false;
                    commonVariablesNotifierProvider
                        .searchTextControllerVisibility = false;

                    break;
                  default:
                    appBarTitle = "Vdo Player";
                }
              },
            ),
          ));
    });
  }
}
