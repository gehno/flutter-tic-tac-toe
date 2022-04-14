import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AppLocalizations getUiText(BuildContext context) {
  final local = AppLocalizations.of(context);

  if (local != null) {
    return local;
  } else {
    throw Exception("No App Localizations found.");
  }
}
