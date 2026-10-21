import 'package:flutter/widgets.dart';

import '../../l10n/app_localizations.dart';

export '../../l10n/app_localizations.dart';

extension LocalizationContext on BuildContext {
  /// Strings for the app's current language: `context.l10n.navToday`.
  AppLocalizations get l10n => AppLocalizations.of(this);
}
