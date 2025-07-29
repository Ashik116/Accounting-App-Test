import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/transaction_controller.dart';

class DashboardView extends StatefulWidget {
  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final transactionController = Get.find<TransactionController>();
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    transactionController.fetchTransactions(); // fetch on load
  }




  @override
  Widget build(BuildContext context) {
    final totalIncome = transactionController.transactions.where((e) => e.type == 'income').fold(0.0, (sum, item) => sum + item.amount);
    final totalExpense = transactionController.transactions.where((e) => e.type == 'expense').fold(0.0, (sum, item) => sum + item.amount);
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:  Text("Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await transactionController.fetchTransactions();
            },
          ),
        ],
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        final totalIncome = transactionController.transactions
            .where((e) => e.type == 'income')
            .fold(0.0, (sum, item) => sum + item.amount);

        final totalExpense = transactionController.transactions
            .where((e) => e.type == 'expense')
            .fold(0.0, (sum, item) => sum + item.amount);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(60),
          child: Center(
            child: Column(
              children: [
                /// Balance Card
                Container(
                  padding: const EdgeInsets.all(26),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black12,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Income: \৳${totalIncome.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.black54,fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        ' Balance: \৳${(totalIncome - totalExpense).toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Expense: \৳${totalExpense.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () => Get.toNamed('/add'),
                        icon: const Icon(Icons.add_circle_outline),
                        label: const Text("Add Transaction"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: () => Get.toNamed('/transactions'),
                        icon: const Icon(Icons.remove_red_eye),
                        label: const Text("View Transaction"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
