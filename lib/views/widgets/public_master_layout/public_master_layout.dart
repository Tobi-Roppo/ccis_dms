import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ccis_dms/constants/dimens.dart';
import 'package:ccis_dms/generated/l10n.dart';
import 'package:ccis_dms/providers/app_preferences_provider.dart';
import 'package:ccis_dms/theme/theme_extensions/app_color_scheme.dart';

class PublicMasterLayout extends StatelessWidget {
  final Widget body;

  const PublicMasterLayout({
    Key? key,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: kToolbarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _toggleThemeButton(context),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: VerticalDivider(
                    width: 1.0,
                    thickness: 1.0,
                    color: themeData.colorScheme.onSurface.withOpacity(0.3),
                    indent: 14.0,
                    endIndent: 14.0,
                  ),
                ),
                const SizedBox(width: kDefaultPadding * 0.5),
              ],
            ),
          ),
          Expanded(
            child: body,
          ),
        ],
      ),
    );
  }

  Widget _toggleThemeButton(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final isFullWidthButton =
        (MediaQuery.of(context).size.width > kScreenWidthMd);

    return SizedBox(
      height: kToolbarHeight,
      width: (isFullWidthButton ? null : 48.0),
      child: TextButton(
        onPressed: () async {
          final provider = context.read<AppPreferencesProvider>();
          final currentThemeMode = provider.themeMode;
          final themeMode = (currentThemeMode != ThemeMode.dark
              ? ThemeMode.dark
              : ThemeMode.light);

          provider.setThemeModeAsync(themeMode: themeMode);
        },
        style: TextButton.styleFrom(
          primary: themeData.colorScheme.onSurface,
          onSurface: themeData.extension<AppColorScheme>()!.primary,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        child: Selector<AppPreferencesProvider, ThemeMode>(
          selector: (context, provider) => provider.themeMode,
          builder: (context, value, child) {
            var icon = Icons.dark_mode_rounded;
            var text = lang.darkTheme;

            if (value == ThemeMode.dark) {
              icon = Icons.light_mode_rounded;
              text = lang.lightTheme;
            }

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: (themeData.textTheme.button!.fontSize! + 4.0),
                ),
                Visibility(
                  visible: isFullWidthButton,
                  child: Padding(
                    padding: const EdgeInsets.only(left: kDefaultPadding * 0.5),
                    child: Text(text),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
