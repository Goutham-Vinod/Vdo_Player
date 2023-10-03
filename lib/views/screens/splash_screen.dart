import 'package:flutter/material.dart';
import 'package:vdo_player/widgets/skeleton.dart';
import 'package:vdo_player/widgets/sort_popup_button.dart';
import '../../controllers/splash_screen_functions.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    splashScreenFunctions(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Vdo Player'),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.grid_view_outlined)),
          IconButton(onPressed: () {}, icon: sortPopupButton(context)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {},
                  leading: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Skeleton(
                      height: MediaQuery.of(context).size.width * 0.29,
                      width: MediaQuery.of(context).size.width * 0.21,
                    ),
                  ),
                  title: Skeleton(
                    height: 10,
                    width: 10,
                  ),
                );
              },
              itemCount: 10,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(thickness: 1)),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(color: Color.fromARGB(255, 155, 155, 155), blurRadius: 20)
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
          selectedItemColor: const Color.fromARGB(250, 61, 0, 121),
          onTap: (value) {},
        ),
      ),
    );
  }
}
