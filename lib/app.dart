import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/themes/app_theme.dart';
import 'presentation/navigation/app_router.dart';

class MpesaApp extends ConsumerStatefulWidget {
  const MpesaApp({super.key});

  @override
  ConsumerState<MpesaApp> createState() => _MpesaAppState();
}

class _MpesaAppState extends ConsumerState<MpesaApp> {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'M-PESA Ethiopia',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      routerConfig: _appRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}