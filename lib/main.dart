import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tic_tac_toe/util/util.dart';
import 'game/home.dart';
import 'menu/drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static const titleColor = Colors.blue;
  static const titleTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.normal,
    fontSize: 20,
  );
  const MyApp({Key? key}) : super(key: key);

  @override
  createState() => _MyAppState();

  static _MyAppState of(BuildContext context) {
    final found = context.findAncestorStateOfType<_MyAppState>();
    if (found != null) {
      return found;
    }
    throw Exception("_MyAppState not found.");
  }
}

class _MyAppState extends State<MyApp> {
  Locale? selectedLanguageCode;

  Map<String, Locale> locales = {
    for (var e in AppLocalizations.supportedLocales) e.languageCode: e
  };

  void setLocale(Locale value) {

    setState(() {
      selectedLanguageCode = value;
    });
  }

  Locale? getLocale() {
    return locales[selectedLanguageCode];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: selectedLanguageCode,
      onGenerateTitle: (BuildContext context) => getUiText(context).ticTacToe,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        primarySwatch: MyApp.titleColor,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getUiText(context).ticTacToe,
          style: MyApp.titleTextStyle,
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: const DrawerWidger(),
      body: const GameHomeScreen(),
      extendBody: false,
    );
  }
}
