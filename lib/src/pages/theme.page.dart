import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../providers.dart';

class ThemePage extends StatefulWidget {
  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  late ThemeMode themeMode;

  @override
  void initState() {
    super.initState();
    this.themeMode = context.read<ThemeModel>().themeMode;
  }

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
      trailing: this.themeMode == mode ? _checkIcon : null,
      onPressed: (_) => change(mode),
    );
  }

  void change(ThemeMode mode) {
    this.themeMode = mode;
    context.read<ThemeModel>().themeMode = mode;
    setState(() {});
  }

  final _checkIcon = Icon(Icons.check, color: Colors.blue);
}
