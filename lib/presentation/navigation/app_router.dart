import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/pin_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/payments/send_money_screen.dart';
import '../screens/payments/pay_with_mpesa_screen.dart';
import '../screens/payments/pay_bill_screen.dart';
import '../screens/payments/buy_airtime_screen.dart';
import '../screens/services/buy_packages_screen.dart';
import '../screens/services/send_to_bank_screen.dart';
import '../screens/services/mpesa_services_screen.dart';
import '../screens/extras/safari_screen.dart';
import '../screens/extras/mini_apps_screen.dart';
import '../../core/constants/app_constants.dart';

class AppRouter {
  late final GoRouter router;
  
  AppRouter() {
    router = GoRouter(
      initialLocation: RouteNames.login,
      debugLogDiagnostics: true,
      routes: _buildRoutes(),
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 80, color: Colors.red),
              const SizedBox(height: 16),
              Text('Page not found: ${state.uri}'),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go(RouteNames.home),
                child: const Text('Go to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  List<RouteBase> _buildRoutes() {
    return [
      GoRoute(
        path: RouteNames.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.pin,
        name: 'pin',
        builder: (context, state) {
          final phoneNumber = state.extra as String? ?? '';
          return PinScreen(phoneNumber: phoneNumber);
        },
      ),
      GoRoute(
        path: RouteNames.home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: RouteNames.sendMoney,
        name: 'sendMoney',
        builder: (context, state) => const SendMoneyScreen(),
      ),
      GoRoute(
        path: RouteNames.payWithMpesa,
        name: 'payWithMpesa',
        builder: (context, state) => const PayWithMpesaScreen(),
      ),
      GoRoute(
        path: RouteNames.payBill,
        name: 'payBill',
        builder: (context, state) {
          final billerName = state.extra as String?;
          return PayBillScreen(billerName: billerName);
        },
      ),
      GoRoute(
        path: RouteNames.buyAirtime,
        name: 'buyAirtime',
        builder: (context, state) => const BuyAirtimeScreen(),
      ),
      GoRoute(
        path: RouteNames.buyPackages,
        name: 'buyPackages',
        builder: (context, state) => const BuyPackagesScreen(),
      ),
      GoRoute(
        path: RouteNames.sendToBank,
        name: 'sendToBank',
        builder: (context, state) => const SendToBankScreen(),
      ),
      GoRoute(
        path: RouteNames.mpesaServices,
        name: 'mpesaServices',
        builder: (context, state) => const MpesaServicesScreen(),
      ),
      GoRoute(
        path: RouteNames.safari,
        name: 'safari',
        builder: (context, state) => const SafariScreen(),
      ),
      GoRoute(
        path: RouteNames.miniApps,
        name: 'miniApps',
        builder: (context, state) => const MiniAppsScreen(),
      ),
    ];
  }
}

// Navigation extension for easier navigation
extension GoRouterExtension on BuildContext {
  void goToLogin() => go(RouteNames.login);
  void goToPin(String phoneNumber) => push(RouteNames.pin, extra: phoneNumber);
  void goToHome() => go(RouteNames.home);
  void goToSendMoney() => push(RouteNames.sendMoney);
  void goToPayWithMpesa() => push(RouteNames.payWithMpesa);
  void goToPayBill([String? billerName]) => push(RouteNames.payBill, extra: billerName);
  void goToBuyAirtime() => push(RouteNames.buyAirtime);
  void goToBuyPackages() => push(RouteNames.buyPackages);
  void goToSendToBank() => push(RouteNames.sendToBank);
  void goToMpesaServices() => push(RouteNames.mpesaServices);
  void goToSafari() => push(RouteNames.safari);
  void goToMiniApps() => push(RouteNames.miniApps);
}