import 'dart:io';

import 'package:commons_classes_functions/src/app_theme.dart';
import 'package:commons_classes_functions/src/flag_extension.dart';
import 'package:commons_classes_functions/src/http_overrides.dart';
import 'package:commons_classes_functions/src/internet_connectivity/internet_connectivity_listener.dart';
import 'package:commons_classes_functions/src/life_cycle_manager.dart';
import 'package:commons_classes_functions/src/permission_utils.dart';
import 'package:commons_classes_functions/src/storage_service.dart';
import 'package:commons_classes_functions/src/text_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart' ;
// use I10n.yaml file  to generate localization files flutter_gen in .dart_tool


final themeModeNotifier = ValueNotifier(ThemeMode.system);
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    LifeCycleManager(child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   Locale _locale = const Locale('ur');

  void _changeLanguage(String code) {
    setState(() {
      _locale = Locale(code);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (_, mode, __) => MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: mode,
        locale: _locale,
      supportedLocales: const [Locale('en'), Locale('ur')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
        home: ConnectivityListener(
            child: const MyHomePage(title: 'Flutter Demo Home Page')),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Theme Toggle App"),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              themeModeNotifier.value =
                  isDark ? ThemeMode.light : ThemeMode.dark;
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(loc.hello),
            Text('Welcome Theme Test',
                style: Theme.of(context).textTheme.headlineLarge),
            const Text(
              'Flag Emoji Extension Example',
            ),
             "This is from text extension".size(24).w400(),
            Text(
              "PK".toFlag.toString(),
              style: const TextStyle(fontSize: 50),
            ),
            ElevatedButton(
                onPressed: () {
                  final storage = StorageService();
                  storage.saveString('username', 'john_doe');
                  storage.saveEncryptedString('password', 'mySecret123');
                  String? username = storage.getString('username');
                  String? password = storage.getEncryptedString('password');
                  print("Password: $password Username: $username");
                },
                child: Text("Storage Service Example")),
            ElevatedButton(
                onPressed: () async {
                  bool granted =
                      await PermissionUtils.handlePermission(Permission.camera);
                  if (granted) {
                    print("Permission granted.");
                  } else {
                    print("Permission denied.");
                  }
                },
                child: Text("Permission Util Example")),
          ],
        ),
      ),
    );
  }
}
