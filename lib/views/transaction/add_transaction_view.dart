// // views/transaction/add_transaction_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/transaction_controller.dart';
import '../../models/transaction_model.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final type = ''.obs;
  final categoryController = TextEditingController();
  final date = DateTime.now().obs;
  final transactionController = Get.find<TransactionController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Add Transaction"),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Title
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                hintText: "Enter transaction title",
                prefixIcon: Icon(Icons.label_outline),
              ),
            ),
            const SizedBox(height: 16),

            // Amount
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Amount",
                prefixIcon: Icon(Icons.attach_money),
                prefixText: "\৳ ",
              ),
            ),
            const SizedBox(height: 16),

            // Transaction Type Dropdown
            DropdownButton<String>(
              hint: const Text('Select Type'),
              value: type.value.isEmpty ? null : type.value, // show selected value or hint
              onChanged: (value) {
                if (value != null) {
                  type.value = value;
                }
              },
              items: ['income', 'expense']
                  .map((e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e[0].toUpperCase() + e.substring(1), // Optional: Capitalize
                ),
              ))
                  .toList(),
            ),
            const SizedBox(height: 16),
            // Category Text Field
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                labelText: "Category",
                prefixIcon: Icon(Icons.category_outlined),
              ),
            ),
            const SizedBox(height: 12),
            // Save Button
            ElevatedButton.icon(
              onPressed: () {
                transactionController.addTransaction(TransactionModel(
                  title: titleController.text,
                  amount: double.parse(amountController.text),
                  type: type.value,
                  category: categoryController.text,
                  date: date.value,
                ));
                Get.back();
              },
              icon: const Icon(Icons.check,color: Colors.white,),
              label: const Text("Save Transaction",style: TextStyle(
                  color: Colors.white
              ),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size.fromHeight(48),
              ),
            ),
            const SizedBox(height: 8),

            // Cancel Button
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
          ],
        ),
      ),
    );
  }
}