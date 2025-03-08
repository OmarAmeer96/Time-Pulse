import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_pulse/core/helpers/spacing.dart';
import 'package:time_pulse/core/widgets/global_appbar.dart';
import 'package:time_pulse/features/settings/cubit/language_cubit.dart';
import 'package:time_pulse/features/settings/cubit/theme_cubit/theme_cubit.dart';
import 'package:time_pulse/generated/l10n.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = context.read<ThemeCubit>();
    return Scaffold(
      appBar: GlobalAppbar(title: S.of(context).settings),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            _buildListTile(
              context,
              title: S.of(context).dark,
              icon: theme.darkMode ? Icons.dark_mode : Icons.light_mode,
              trailing: Switch(
                activeColor: Theme.of(context).colorScheme.primary,
                value: theme.darkMode,
                onChanged: (value) {
                  theme.toggleTheme();
                },
              ),
            ),
            verticalSpace(20),
            _buildListTile(
              context,
              title: S.of(context).language,
              icon: Icons.language,
              onTap: () {
                _showLanguageDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: context.read<ThemeCubit>().darkMode
            ? Colors.grey.shade500
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: TextStyle(color: Colors.grey.shade500),
              )
            : null,
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            S.of(context).select_language,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(
                activeColor: Theme.of(context).colorScheme.primary,
                title: Text(
                  S.of(context).english,
                  style: TextStyle(
                      color: context.read<ThemeCubit>().darkMode
                          ? Colors.white
                          : Colors.black),
                ),
                value: "en",
                groupValue: Localizations.localeOf(context).languageCode,
                onChanged: (value) {
                  context.read<LanguageCubit>().toggleLanguage();
                  Navigator.pop(context);
                },
              ),
              RadioListTile(
                activeColor: Theme.of(context).colorScheme.primary,
                title: Text(
                  S.of(context).arabic,
                  style: TextStyle(
                      color: context.read<ThemeCubit>().darkMode
                          ? Colors.white
                          : Colors.black),
                ),
                value: "ar",
                groupValue: Localizations.localeOf(context).languageCode,
                onChanged: (value) {
                  context.read<LanguageCubit>().toggleLanguage();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
