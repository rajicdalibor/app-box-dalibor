import 'package:flutter/material.dart';
import 'package:frontend/components/custom_drawer.dart';
import 'package:frontend/providers/user_providers.dart';
import 'package:frontend/services/hello_world_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/services/user_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeDrawerPage extends ConsumerWidget {
  const HomeDrawerPage({
    super.key,
  });

  Future<String?> getHelloWorld() async {
    return await HelloWorldService.helloWorld();
  }

  @override
  Widget build(BuildContext context, ref) {
    final translation = AppLocalizations.of(context)!;
    final user = ref.read(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(translation.homePageTitle),
      ),
      drawer: const CustomDrawer(),
      body: FutureBuilder<String?>(
        future: getHelloWorld(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.hasData && snapshot.data != null) {
            if (user != null) {
              UserService.updateInstalledAppVersion(user);
            }
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: Text(
                        translation.hello,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    Text(
                      snapshot.data!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),
            );
          }

          return const Center(child: Text('No data available'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Hey hey hey');
        },
        child: const Icon(Icons.bubble_chart),
      ),
    );
  }
}
