import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/transaction_controller.dart';

class TransactionListView extends StatelessWidget {
  final controller = Get.find<TransactionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      body: Obx(() {
        final transactions = controller.transactions;

        if (transactions.isEmpty) {
          return const Center(child: Text('No transactions available.'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final tx = transactions[index];

            return Dismissible(
              key: Key(tx.id ?? index.toString()),
              onDismissed: (direction) {
                controller.deleteTransaction(tx.id!);
                Get.snackbar('Deleted', '${tx.title} removed',
                    backgroundColor: Colors.red.shade100,
                    snackPosition: SnackPosition.BOTTOM);
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              secondaryBackground: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: Text(
                    tx.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(tx.category),
                  trailing: Text(
                    '\৳${tx.amount.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: tx.type == 'income' ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
