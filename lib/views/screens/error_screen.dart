import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ccis_dms/app_router.dart';
import 'package:ccis_dms/constants/dimens.dart';
import 'package:ccis_dms/generated/l10n.dart';
import 'package:ccis_dms/providers/user_data_provider.dart';
import 'package:ccis_dms/theme/theme_extensions/app_color_scheme.dart';
import 'package:ccis_dms/views/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:ccis_dms/views/widgets/public_master_layout/public_master_layout.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userDataProvider = context.read<UserDataProvider>();

    if (userDataProvider.isUserLoggedIn()) {
      return PortalMasterLayout(
        body: _content(context),
      );
    } else {
      return PublicMasterLayout(
        body: _content(context),
      );
    }
  }

  Widget _content(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final appColorScheme = Theme.of(context).extension<AppColorScheme>()!;

    return ListView(
      padding: const EdgeInsets.all(kDefaultPadding),
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: kDefaultPadding * 5.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: kDefaultPadding),
                child: Text(
                  '404',
                  style: themeData.textTheme.headline2!.copyWith(
                    color: appColorScheme.warning,
                  ),
                ),
              ),
              SizedBox(
                width: 300.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: kDefaultPadding * 0.5),
                      child: Text(
                        lang.error404Title,
                        style: themeData.textTheme.headline6!.copyWith(
                          color: appColorScheme.warning,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: kDefaultPadding * 1.5),
                      child: Text(lang.error404Message),
                    ),
                    SizedBox(
                      height: 36.0,
                      width: 100.0,
                      child: ElevatedButton(
                        onPressed: () => GoRouter.of(context).go(RouteUri.home),
                        child: Text(lang.homePage),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
