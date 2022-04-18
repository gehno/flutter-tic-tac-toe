import 'package:flutter/material.dart';
import 'package:tic_tac_toe/util/util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Map<String, LanguageInfo> infos = {
    for (var e in AppLocalizations.supportedLocales)
      e.languageCode: LanguageInfo(e)
  };
  void setSelectedLanguage(LanguageInfo? value) {
    if (value != null) {
      setState(() {
        MyApp.of(context).setLocale(value.locale);
      });
    }
  }

  String get selectedLanguage {
    Locale? locale = MyApp.of(context).locale;
    if (locale != null) {
      return locale.languageCode;
    }
    return Localizations.localeOf(context).languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getUiText(context).settings),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          Center(child: Text(getUiText(context).language)),
          Center(
            child: DropdownButton<LanguageInfo>(
              value: infos[selectedLanguage],
              onChanged: (value) => {setSelectedLanguage(value)},
              items: infos.values
                  .map<DropdownMenuItem<LanguageInfo>>((LanguageInfo value) {
                return DropdownMenuItem<LanguageInfo>(
                  value: value,
                  child: value.languageWidget,
                );
              }).toList(),
            ),
          ),
          const Center(child: Text("More Options...")),
          Center(
            child: Slider(
              min: 0,
              max: 10,
              value: 0,
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }
}

class LanguageInfo {
  late final Widget languageCodeWidget;
  late final Widget languageWidget;

  final Locale locale;

  LanguageInfo(this.locale) {
    languageCodeWidget = Text(locale.languageCode);

    switch (locale.languageCode) {
      case "de":
        languageWidget = showSvgFlag("de");
        break;
      case "en":
        languageWidget = showSvgFlag("gb");
        break;
      default:
        languageWidget = languageCodeWidget;
    }
  }
}
