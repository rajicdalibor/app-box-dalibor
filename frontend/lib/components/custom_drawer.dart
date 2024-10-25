import 'package:flutter/material.dart';
import 'package:frontend/navigation/route_names.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  bool isCurrentLocation(BuildContext context, String location) {
    return location ==
        GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context)!;
    return Drawer(
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: 150,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Text(
                        translations.naveMenuDrawerHeaderTitle,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              onTap: () {
                // close the drawer
                context.pop(context);
                // navigate to the profile page
                if (!isCurrentLocation(context, routeHome)) {
                  context.push(routeHome);
                }
              },
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const Icon(Icons.home),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(translations.navMenuItemHome),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                // close the drawer
                context.pop(context);
                // navigate to the profile page
                if (!isCurrentLocation(context, routeProfile)) {
                  context.push(routeProfile);
                }
              },
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const Icon(Icons.face),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(translations.navMenuItemProfile),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                // close the drawer
                context.pop(context);
                // navigate to the profile page
                if (!isCurrentLocation(context, routeSettings)) {
                  context.push(routeSettings);
                }
              },
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const Icon(Icons.settings),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(translations.navMenuItemSettings),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
