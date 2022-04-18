import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

AppLocalizations getUiText(BuildContext context) {
  final local = AppLocalizations.of(context);

  if (local != null) {
    return local;
  } else {
    throw Exception("No App Localizations found.");
  }
}

Widget showSvgFlag(String languageCode) {
  return SizedBox(
    height: 20,
    width: 40,
    child: SvgPicture.asset(
      'icons/flags/svg/$languageCode.svg',
      package: 'country_icons',
    ),
  );
}
