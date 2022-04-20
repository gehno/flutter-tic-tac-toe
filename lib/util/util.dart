import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math';

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

Color randomColor() {
  return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
}

bool isNight() {
  DateTime now = DateTime.now();
  print(now);
  if (now.hour.isBetween(0, 6) || now.hour.isBetween(18, 24)) {
    return true;
  }
  return false;
}

extension Range on num {
  bool isBetween(num from, num to) {
    return from <= this && this <= to;
  }
}
