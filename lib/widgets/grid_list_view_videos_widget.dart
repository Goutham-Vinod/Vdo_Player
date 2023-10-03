import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vdo_player/controllers/common_Provider.dart';
import 'package:vdo_player/controllers/common_functions.dart';
import 'package:vdo_player/widgets/threedot_widget.dart';

class GridListViewVideosWidget extends StatelessWidget {
  GridListViewVideosWidget(
      {required this.dataList,
      this.onTapFunction,
      this.enableDeleteAtThreeDot,
      this.enableThreeDot,
      this.deleteFunction,
      super.key});
  final List dataList;
  final Function? onTapFunction;

  final Function? deleteFunction;
  final bool? enableThreeDot; //null is treated as false
  final bool? enableDeleteAtThreeDot; //null is treated as false

  Widget build(BuildContext context) {
    return Consumer<CommonVariablesNotifier>(
        builder: (context, commonVariables, child) {
      return commonVariables.gridViewState == 1
          ? Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: GridView.builder(
                  itemCount: dataList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (onTapFunction != null) {
                          onTapFunction!(index);
                        }
                      },
                      child: Column(
                        children: [
                          Stack(children: [
                            Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                                child: FutureBuilder(
                                  future: generateThumb(dataList[index]),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData &&
                                        snapshot.data != 'null') {
                                      return Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.28,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.40,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: FileImage(
                                                    File(snapshot.data!)))),
                                      );
                                    } else {
                                      return Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.29,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.41,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.contain,
                                                image: AssetImage(
                                                    'assets/video_thumbnail_icon.png'))),
                                      );
                                    }
                                  },
                                )),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .38,
                              height: MediaQuery.of(context).size.width * .29,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: FutureBuilder(
                                    future: getVideoInfo(dataList[index]),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        double milliseconds = snapshot.data;
                                        twoDigit(int n) =>
                                            n.toString().padLeft(2, "0");
                                        String hours =
                                            (milliseconds / (1000 * 60 * 60))
                                                .floor()
                                                .toString();
                                        String minutes = twoDigit(
                                            (milliseconds / (1000 * 60) % 60)
                                                .floor());
                                        String seconds = twoDigit(
                                            (milliseconds / 1000 % 60).floor());

                                        if (hours != "0") {
                                          return Text(
                                            "$hours:$minutes:$seconds",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .035,
                                                color: Colors.white,
                                                backgroundColor: Colors.black),
                                          );
                                        } else {
                                          return Text(
                                            "$minutes:$seconds",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .035,
                                                color: Colors.white,
                                                backgroundColor: Colors.black),
                                          );
                                        }
                                      } else {
                                        return Text("");
                                      }
                                    }),
                              ),
                            )
                          ]),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .5,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .3,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                    child: Text(
                                      truncateWithEllipsis(
                                          25, dataList[index].split('/').last),
                                      style: const TextStyle(fontSize: 14),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                enableThreeDot == null
                                    ? const Text("")
                                    : ThreeDot(
                                        videoPath: dataList[index],
                                        enableDelete: enableDeleteAtThreeDot,
                                        index: index,
                                        deleteFunction: (index) {
                                          if (deleteFunction != null) {
                                            return deleteFunction!(index);
                                          }
                                        })
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            )
          : dataList.isEmpty
              ? Center(child: Text("No videos found"))
              : Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            if (onTapFunction != null) {
                              onTapFunction!(index);
                            }
                          },
                          leading: Stack(
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: FutureBuilder(
                                    future: generateThumb(dataList[index]),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData &&
                                          snapshot.data != 'null') {
                                        return Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .18,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: FileImage(
                                                      File(snapshot.data!)))),
                                        );
                                      } else {
                                        return Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .17,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                      'assets/video_thumbnail_icon.png'))),
                                        );
                                      }
                                    },
                                  )),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .17,
                                height: MediaQuery.of(context).size.width * .13,
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: FutureBuilder(
                                      future: getVideoInfo(dataList[index]),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          double milliseconds = snapshot.data;
                                          twoDigit(int n) =>
                                              n.toString().padLeft(2, "0");
                                          String hours =
                                              (milliseconds / (1000 * 60 * 60))
                                                  .floor()
                                                  .toString();
                                          String minutes = twoDigit(
                                              (milliseconds / (1000 * 60) % 60)
                                                  .floor());
                                          String seconds = twoDigit(
                                              (milliseconds / 1000 % 60)
                                                  .floor());

                                          if (hours != "0") {
                                            return Text(
                                              "$hours:$minutes:$seconds",
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          .03,
                                                  color: Colors.white,
                                                  backgroundColor:
                                                      Colors.black),
                                            );
                                          } else {
                                            return Text(
                                              "$minutes:$seconds",
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          .03,
                                                  color: Colors.white,
                                                  backgroundColor:
                                                      Colors.black),
                                            );
                                          }
                                        } else {
                                          return Text("");
                                        }
                                      }),
                                ),
                              ),
                            ],
                          ),
                          title: Text(truncateWithEllipsis(
                              25, dataList[index].split('/').last)),
                          trailing: enableThreeDot == null
                              ? const Text("")
                              : ThreeDot(
                                  videoPath: dataList[index],
                                  enableDelete: enableDeleteAtThreeDot,
                                  index: index,
                                  deleteFunction: (index) {
                                    if (deleteFunction != null) {
                                      return deleteFunction!(index);
                                    }
                                  }),
                        );
                      },
                      itemCount: dataList.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(thickness: 1)),
                );
    });
  }
}
