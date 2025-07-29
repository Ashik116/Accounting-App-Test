// routes/app_pages.dart
import 'package:get/get.dart';
import '../views/auth/login_view.dart';
import '../views/auth/register_view.dart';
import '../views/dashboard/dashboard_view.dart';
import '../views/splash/splash_screen.dart';
import '../views/transaction/add_transaction_view.dart';
import '../views/transaction/transaction_list_view.dart';

class AppPages {
  static const initial = '/splash';

  static final routes = [
    GetPage(name: '/splash', page: () => SplashScreenPage()),
    GetPage(name: '/login', page: () => LoginView()),
    GetPage(name: '/register', page: () => RegisterPage()),
    GetPage(name: '/dashboard', page: () => DashboardView()),
    GetPage(name: '/add', page: () =>  AddTransactionPage()),
    GetPage(name: '/transactions', page: () => TransactionListView()),
  ];
}