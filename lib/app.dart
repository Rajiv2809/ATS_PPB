import 'package:flutter/material.dart';

import 'app_scope.dart';
import 'app_state.dart';
import 'screens/app_shell.dart';
import 'screens/food_detail_screen.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/unknown_route_screen.dart';

const _forest = Color(0xff19564c);
const _cream = Color(0xfffbf8f2);
const _ink = Color(0xff262d28);

class JejakRasaApp extends StatefulWidget {
  const JejakRasaApp({super.key});

  @override
  State<JejakRasaApp> createState() => _JejakRasaAppState();
}

class _JejakRasaAppState extends State<JejakRasaApp> {
  final AppState _state = AppState();

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      state: _state,
      child: MaterialApp(
        title: 'JejakRasa',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: _cream,
          colorScheme: ColorScheme.fromSeed(
            seedColor: _forest,
            surface: _cream,
            primary: _forest,
            onSurface: _ink,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: _cream,
            foregroundColor: _ink,
            surfaceTintColor: Colors.transparent,
            titleTextStyle: TextStyle(
              color: _ink,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          navigationBarTheme: NavigationBarThemeData(
            backgroundColor: Colors.white,
            indicatorColor: _forest.withValues(alpha: 0.12),
            labelTextStyle: const WidgetStatePropertyAll(
              TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Colors.black.withValues(alpha: .08),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Colors.black.withValues(alpha: .08),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: _forest, width: 1.5),
            ),
          ),
        ),
        initialRoute: '/',
        onGenerateRoute: _generateRoute,
      ),
    );
  }

  Route<void> _generateRoute(RouteSettings settings) {
    final page = switch (settings.name) {
      '/' => const SplashScreen(),
      '/login' => const LoginScreen(),
      '/app' => const AppShell(),
      '/detail' => _detailScreen(settings.arguments),
      _ => const UnknownRouteScreen(),
    };
    return MaterialPageRoute<void>(settings: settings, builder: (_) => page);
  }

  Widget _detailScreen(Object? arguments) {
    final foodId = arguments;
    if (foodId is String) {
      final food = _state.foodById(foodId);
      if (food != null) return FoodDetailScreen(food: food);
    }
    return const UnknownRouteScreen();
  }
}
