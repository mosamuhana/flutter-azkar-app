import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../nav.dart';
import '../extensions.dart';
import '../boxes.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkMode = false;

  @override
  void initState() {
    super.initState();
    darkMode = ThemeSetting.instance.isDark;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(t.settings)),
      body: buildSettingsList(t),
    );
  }

  Widget buildSettingsList(AppLocalizations t) {
    final langName =
        LocaleSetting.instance.value == 'ar' ? t.arabic : t.english;
    final themeName = ThemeSetting.instance.themeMode.getLocalizedName(t);

    return SettingsList(
      sections: [
        SettingsSection(
          title: t.common,
          tiles: [
            SettingsTile(
              title: t.language,
              subtitle: langName,
              leading: Icon(Icons.language),
              onPressed: (context) => Nav.showLanguage(context),
            ),
            SettingsTile(
              title: t.theme,
              subtitle: themeName,
              leading: Icon(Icons.language),
              onPressed: (context) => Nav.showTheme(context),
            ),
          ],
        ),
      ],
    );
  }
}
