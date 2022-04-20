import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tic_tac_toe/util/util.dart';
import 'game/home.dart';
import 'menu/drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
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
  Locale? _locale;
  Color _mainColor = randomColor();
  Brightness _brightness = isNight()?Brightness.dark:Brightness.light;

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  Locale? get locale {
    return _locale;
  }

  void setMainColor(Color value) {
    setState(() {
      _mainColor = value;
    });
  }

  Color get mainColor {
    return _mainColor;
  }

  void setBrightness(Brightness value) {
    setState(() {
      _brightness = value;
    });
  }

  Brightness get brightness {
    return _brightness;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      onGenerateTitle: (BuildContext context) => getUiText(context).ticTacToe,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: mainColor, brightness: brightness),
        // primarySwatch: mainColor,
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
      drawer: const DrawerWidget(),
      body: const GameHomeScreen(),
      extendBody: true,
    );
  }
}
