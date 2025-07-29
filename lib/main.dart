import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_account_app/routes/app_page.dart';

import 'controllers/auth_controller.dart';
import 'controllers/transaction_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());
  Get.put(TransactionController());
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Accounting App',
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
