import 'package:flutter/foundation.dart';
import 'common_functions.dart';

class CommonVariablesNotifier with ChangeNotifier {
// common variables

  List _videosGlobal = [];
  set videosGlobal(val) {
    _videosGlobal = val;
    notifyListeners();
  }

  get videosGlobal => _videosGlobal;

  int _selectedNaviBarIndex = 0;
  set selectedNaviBarIndex(val) {
    _selectedNaviBarIndex = val;
    notifyListeners();
  }

  get selectedNaviBarIndex => _selectedNaviBarIndex;

  int _gridViewState = 0;
  set gridViewState(val) {
    _gridViewState = val;
    notifyListeners();
  }

  get gridViewState => _gridViewState;

  refresh() {
    notifyListeners();
  }

//home screen variables
  bool _searchTextControllerVisibility = false;
  set searchTextControllerVisibility(val) {
    _searchTextControllerVisibility = val;
    notifyListeners();
  }

  get searchTextControllerVisibility => _searchTextControllerVisibility;

  //folders page

  get uniqueFolders => findUniqueFolders(videosGlobal);

// playlist page
  double userTapPosX = 0;
  double userTapPosY = 0;
}

String selectedFolderPath = "Default path";
int selectedPlaylistFolderIndex = 0;
