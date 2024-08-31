import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:story_app/presentasi/provider/auth/data_user_provider.dart';
import 'package:story_app/presentasi/router/router_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<String?>>(
      dataUserProvider,
      (previous, next) {
        next.when(
          data: (token) {
            if (token == null || token.isEmpty) {
              ref.read(routerProvider).goNamed("Login");
            }
          },
          loading: () {},
          error: (error, stack) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.toString()),
              ),
            );
          },
        );
      },
    );

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                ref.read(dataUserProvider.notifier).logout();
              },
              child: const Text("Keliuar"),
            ),
          ],
        ),
      ),
    );
  }
}
