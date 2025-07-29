// controllers/transaction_controller.dart
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/transaction_model.dart';

class TransactionController extends GetxController {
  final transactions = <TransactionModel>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  @override
  void onInit() {
    fetchTransactions();
    super.onInit();
  }

  Future<void> fetchTransactions() async {
    final snapshot = await _firestore.collection('transactions').get();
    transactions.value = snapshot.docs.map((doc) => TransactionModel.fromDoc(doc)).toList();
  }

  void addTransaction(TransactionModel transaction) async {
    await _firestore.collection('transactions').add(transaction.toJson());
    fetchTransactions();
  }

  void deleteTransaction(String id) async {
    await _firestore.collection('transactions').doc(id).delete();
    fetchTransactions();
  }
}