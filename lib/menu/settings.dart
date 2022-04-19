import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:tic_tac_toe/util/util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(getUiText(context).language),
            trailing: DropdownButton<LanguageInfo>(
              value: infos[selectedLanguage],
              onChanged: (value) => {setSelectedLanguage(value)},
              items: infos.values
                  .map<DropdownMenuItem<LanguageInfo>>((LanguageInfo value) {
                return DropdownMenuItem<LanguageInfo>(
                  value: value,
                  child: value.widget,
                );
              }).toList(),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: Text(getUiText(context).color),
            trailing: ElevatedButton(
              child:
                  Text("#${Colors.red.value.toRadixString(16).toUpperCase()}"),
              onPressed: () {
                showColorPickerDialog(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

void showColorPickerDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(getUiText(context).color),
          content: SingleChildScrollView(
            child: ColorPicker(
              onColorChanged: (value) {}, 
              pickerColor: Colors.red,
            ),
          ),
        );
      });
}

class LanguageInfo {
  late final Widget languageCodeWidget;
  late final Widget flagWidget;

  final Locale locale;

  LanguageInfo(this.locale) {
    languageCodeWidget = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(locale.languageCode.toUpperCase()),
    );

    switch (locale.languageCode) {
      case "de":
        flagWidget = showSvgFlag("de");
        break;
      case "en":
        flagWidget = showSvgFlag("gb");
        break;
      default:
        flagWidget = Container();
    }
  }

  Widget get widget {
    return Row(
      children: [
        flagWidget,
        languageCodeWidget,
      ],
    );
  }
}
