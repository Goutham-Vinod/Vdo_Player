import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vdo_player/controllers/common_Provider.dart';
import 'package:vdo_player/controllers/db_functions.dart';
import 'package:vdo_player/models/db_models/db_model.dart';
import 'package:vdo_player/views/screens/splash_screen.dart';
// import 'package:device_preview/device_preview.dart';

void main(List<String> args) async {
  await Hive.initFlutter();
  Hive.registerAdapter(PlaylistModelAdapter());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  // runApp(DevicePreview(enabled: true, builder: (context) => const MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CommonVariablesNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => DbNotifier(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.purple),
        home: const SplashScreen(),
      ),
    );
  }
}
