import 'package:flutter/material.dart';
import 'package:frontend/providers/local_provider.dart';
import 'package:frontend/providers/theme_provider.dart';
import 'package:frontend/utils/language_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsDrawerPage extends ConsumerWidget {
  const SettingsDrawerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = AppLocalizations.of(context)!;
    final themeRef = ref.watch(themeProvider);
    final localeRef = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(translations.settingsPageTitle),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const Divider(),
            ListTile(
              title: Text(translations.settingsPageTheme),
              trailing: Switch(
                value: themeRef == Brightness.dark,
                onChanged: (value) {
                  ref.read(themeProvider.notifier).toggleTheme(value);
                },
              ),
            ),
            const Divider(),
            ListTile(
              title: Text(translations.settingsPageLanguage),
              trailing: DropdownButton<SupportedLanguage>(
                value: localeRef,
                onChanged: (SupportedLanguage? value) {
                  ref.read(localeProvider.notifier).setLang(value!);
                },
                items: SupportedLanguage.values
                    .map<DropdownMenuItem<SupportedLanguage>>(
                        (SupportedLanguage value) {
                  return DropdownMenuItem<SupportedLanguage>(
                    value: value,
                    child: Text(value.getLocale().toString()),
                  );
                }).toList(),
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
