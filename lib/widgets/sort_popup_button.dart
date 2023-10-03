import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vdo_player/controllers/common_functions.dart';
import 'package:vdo_player/controllers/common_Provider.dart';

Widget sortPopupButton(BuildContext context) {
  return PopupMenuButton(
    icon: const Icon(
      Icons.sort,
      size: 20,
    ),
    itemBuilder: (context) {
      List<PopupMenuItem<String>> popupMenuItemList = [
        const PopupMenuItem(value: "A to Z", child: Text("A to Z")),
        const PopupMenuItem(value: "Z to A", child: Text("Z to A")),
      ];

      return popupMenuItemList;
    },
    onSelected: (String? value) {
      switch (value) {
        case "A to Z":
          Provider.of<CommonVariablesNotifier>(context, listen: false)
              .videosGlobal
              .sort((a, b) {
            return findFileName(a)
                .toString()
                .toLowerCase()
                .compareTo(findFileName(b).toString().toLowerCase());
          });
          Provider.of<CommonVariablesNotifier>(context, listen: false)
              .refresh();
          break;
        case "Z to A":
          Provider.of<CommonVariablesNotifier>(context, listen: false)
              .videosGlobal
              .sort((a, b) {
            return findFileName(b)
                .toString()
                .toLowerCase()
                .compareTo(findFileName(a).toString().toLowerCase());
          });
          Provider.of<CommonVariablesNotifier>(context, listen: false)
              .refresh();
          break;
        default:
      }
    },
  );
}
