import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:story_app/presentasi/provider/auth/data_user_provider.dart';
import 'package:story_app/presentasi/router/router_provider.dart';

class SplashScreenPage extends ConsumerWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<String?>>(
      dataUserProvider,
      (previous, next) {
        next.when(
          data: (token) {
            Future.delayed(
              const Duration(milliseconds: 1000),
              () {
                if (token == null) {
                  ref.read(routerProvider).goNamed("Login");
                } else {
                  ref.read(routerProvider).goNamed("Home");
                }
              },
            );
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
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Image.asset("assets/image.png"),
            const Text(
              "Story App",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
