import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tabungan_frontend/core/models/transaction_model.dart';
import 'package:flutter/foundation.dart';

class TransactionRepository {
  // Singleton pattern
  static final TransactionRepository _instance = TransactionRepository._internal();
  factory TransactionRepository() => _instance;
  TransactionRepository._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionPath = 'transactions';

  // ValueNotifier for UI updates
  final ValueNotifier<List<TransactionModel>> transactionsNotifier = ValueNotifier([]);

  Future<void> init() async {
    // Listen to real-time updates from Firestore
    _firestore.collection(_collectionPath).snapshots().listen((snapshot) {
      final list = snapshot.docs.map((doc) {
        return TransactionModel.fromJson(doc.data(), doc.id);
      }).toList();
      
      list.sort((a, b) => b.date.compareTo(a.date));
      transactionsNotifier.value = list;
    });
  }

  Future<void> loadTransactions() async {
    // Real-time listener handles the loading, so this can be empty or just fetch once if preferred.
    // Kept here for compatibility with existing code calling loadTransactions().
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    try {
      await _firestore.collection(_collectionPath).doc(transaction.id).set(transaction.toJson());
    } catch (e) {
      debugPrint('Error adding transaction: $e');
    }
  }

  Future<void> deleteTransaction(String id) async {
    try {
      await _firestore.collection(_collectionPath).doc(id).delete();
    } catch (e) {
      debugPrint('Error deleting transaction: $e');
    }
  }

  Future<void> updateTransaction(TransactionModel transaction) async {
    try {
      await _firestore.collection(_collectionPath).doc(transaction.id).update(transaction.toJson());
    } catch (e) {
      debugPrint('Error updating transaction: $e');
    }
  }
}
