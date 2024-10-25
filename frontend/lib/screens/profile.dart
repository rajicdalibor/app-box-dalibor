import 'package:flutter/material.dart';
import 'package:frontend/components/display_data.dart';
import 'package:frontend/navigation/route_names.dart';
import 'package:frontend/providers/user_providers.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/user_service.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.watch(userProvider);
    final translations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            DisplayData(
              label: translations.emailLabel,
              value: user?.email ?? '',
            ),
            DisplayData(
              label: translations.nameLabel,
              value: user?.displayName() ?? '',
            ),
            DisplayData(
              label: translations.birthdateLabel,
              value: user?.birthDate ?? '',
            ),
            DisplayData(
              label: translations.profilePageAddressLabel,
              value: user?.googleAddress?.fullAddress ?? '',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: OutlinedButton(
                onPressed: () {
                  context.push(routeProfileEdit);
                },
                child: Text(translations.profileEditPage),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: ElevatedButton(
                onPressed: () async {
                  if (user != null) {
                    await UserService.updateLastKnownActivity(user.id!);
                  }
                  AuthService.signOut();
                },
                child: Text(translations.logoutLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
