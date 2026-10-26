import 'package:flutter/material.dart';

extension LocalizationExtension on BuildContext {
  Locale get currentLocale => Localizations.localeOf(this);
}