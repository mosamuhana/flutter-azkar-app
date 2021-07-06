import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../services/locale.model.dart';
import '../nav.dart';
import '../services/dark-mode.model.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkMode = false;

  @override
  void initState() {
    super.initState();
    darkMode = context.read<DarkModeModel>().value;
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
    final localeName = context.read<LocaleModel>().name;
    var langName = localeName == 'ar' ? t.arabic : t.english;
    final darkModeModel = context.watch<DarkModeModel>();

    return SettingsList(
      sections: [
        SettingsSection(
          title: t.common,
          tiles: [
            SettingsTile(
              title: t.language,
              //subtitle: 'English',
              subtitle: langName,
              leading: Icon(Icons.language),
              onPressed: (context) => Nav.showLanguage(context),
            ),
            SettingsTile.switchTile(
              title: t.darkMode,
              leading: Icon(Icons.dark_mode),
              switchValue: darkMode,
              onToggle: (value) {
                darkModeModel.value = value;
                darkMode = value;
                setState(() {});
              },
            ),
          ],
        ),
      ],
    );
  }
}
