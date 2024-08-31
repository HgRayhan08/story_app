import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:story_app/presentasi/page/detail_story/detail_story_page.dart';
import 'package:story_app/presentasi/page/form_create_story/form_create_story_page.dart';
import 'package:story_app/presentasi/page/home_page/home_page.dart';
import 'package:story_app/presentasi/page/login/login_page.dart';
import 'package:story_app/presentasi/page/registrasi/registrasi_page.dart';
import 'package:story_app/presentasi/page/splash_screen/splash_screen_page.dart';

part 'router_provider.g.dart';

@Riverpod(keepAlive: true)
Raw<GoRouter> router(RouterRef ref) => GoRouter(
      routes: [
        GoRoute(
          path: "/SplashScreen",
          name: "SplashScreen",
          builder: (context, state) => const SplashScreenPage(),
        ),
        GoRoute(
          path: "/Home",
          name: "Home",
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: "/Login",
          name: "Login",
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: "/Register",
          name: "Register",
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: "/Create",
          name: "Create",
          builder: (context, state) => const FormCreateStoryPage(),
        ),
        GoRoute(
          path: "/Detail",
          name: "Detail",
          builder: (context, state) => DetailStoryPage(state.extra as String),
        )
      ],
      initialLocation: "/SplashScreen",
      debugLogDiagnostics: false,
    );
