// models/transaction_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  String? id;
  String title;
  double amount;
  String type;
  String category;
  DateTime date;

  TransactionModel({
    this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'amount': amount,
    'type': type,
    'category': category,
    'date': date.toIso8601String(),
  };

  static TransactionModel fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TransactionModel(
      id: doc.id,
      title: data['title'],
      amount: data['amount'],
      type: data['type'],
      category: data['category'],
      date: DateTime.parse(data['date']),
    );
  }
}