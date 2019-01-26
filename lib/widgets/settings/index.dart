import 'package:flutter/material.dart';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:hear2learn/app.dart';
import 'package:hear2learn/themes.dart';
import 'package:hear2learn/widgets/common/bottom_app_bar_player.dart';

class Settings extends StatefulWidget {
  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  static const String THEME_PREF = 'theme';
  final App app = App();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String theme;

  @override
  void initState() {
    super.initState();
    theme = app.prefs.getString(THEME_PREF);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            InputDecorator(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isDense: true,
                  items: ThemeProvider.THEME_LIST.map((String theme) => DropdownMenuItem<String>(
                    child: Text(theme),
                    value: theme,
                  )).toList(),
                  onChanged: (String newTheme) {
                    DynamicTheme.of(context).setTheme(newTheme);
                    setState(() {
                      theme = newTheme;
                    });

                    app.prefs.setString(THEME_PREF, newTheme);
                  },
                  value: theme ?? ThemeProvider.DEFAULT_THEME,
                ),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: const Icon(Icons.color_lens),
                labelText: 'Theme',
              ),
            ),
          ],
          padding: const EdgeInsets.all(16.0),
        ),
      ),
      bottomNavigationBar: const BottomAppBarPlayer(),
    );
  }
}
