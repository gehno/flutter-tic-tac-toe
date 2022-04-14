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
  List<LanguageInfo> infos =
      AppLocalizations.supportedLocales.map((e) => LanguageInfo(e)).toList();
  int selectedLanguage = 0; //todo: has to load from storage

  void setSelectedLanguage(LanguageInfo? value) {
    if (value != null) {
      setState(() {
        selectedLanguage = infos.indexOf(value);
        MyApp.of(context).setLocale(value.locale);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(getUiText(context).language),
                ),
                DropdownButton<LanguageInfo>(
                  value: infos[selectedLanguage],
                  onChanged: (value) => {setSelectedLanguage(value)},
                  items: infos.map<DropdownMenuItem<LanguageInfo>>(
                      (LanguageInfo value) {
                    return DropdownMenuItem<LanguageInfo>(
                      value: value,
                      child: value.languageWidget,
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
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

  SizedBox showSvgFlag(String languageCode) {
    return SizedBox(
        height: 20,
        width: 40,
        child: SvgPicture.asset(
          'icons/flags/svg/$languageCode.svg',
          package: 'country_icons',
        ));
  }
}
