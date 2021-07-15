import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../boxes.dart';

class ThemePage extends StatefulWidget {
  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(t.theme)),
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: [
              _buildTile(ThemeMode.dark, t.dark),
              _buildTile(ThemeMode.light, t.light),
              _buildTile(ThemeMode.system, t.system),
            ],
          ),
        ],
      ),
    );
  }

  SettingsTile _buildTile(ThemeMode mode, String title) {
    return SettingsTile(
      title: title,
      trailing: ThemeSetting.instance.themeMode == mode ? _checkIcon : null,
      onPressed: (_) => change(mode),
    );
  }

  void change(ThemeMode mode) {
    ThemeSetting.instance.themeMode = mode;
    setState(() {});
  }

  final _checkIcon = Icon(Icons.check, color: Colors.blue);
}
