import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../boxes.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(t.language)),
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: [
              _buildTile('en', t.english),
              _buildTile('ar', t.arabic),
            ],
          ),
        ],
      ),
    );
  }

  SettingsTile _buildTile(String code, String title) {
    return SettingsTile(
      title: title,
      trailing: LocaleSetting.instance.value == code ? _checkIcon : null,
      onPressed: (_) {
        LocaleSetting.instance.value = code;
        setState(() {});
      },
    );
  }

  final _checkIcon = Icon(Icons.check, color: Colors.blue);
}
