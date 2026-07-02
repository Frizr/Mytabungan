enum TransactionType { deposit, withdrawal }

class TransactionModel {
  final String id;
  final String userId;
  final double amount;
  final String title;
  final String description;
  final TransactionType type;
  final DateTime date;
  final String sumberDana;

  TransactionModel({
    required this.id,
    required this.userId,
    required this.amount,
    this.title = '',
    required this.description,
    required this.type,
    required this.date,
    this.sumberDana = 'Cash',
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json, String documentId) {
    return TransactionModel(
      id: documentId,
      userId: json['userId'] ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] == 'withdrawal' ? TransactionType.withdrawal : TransactionType.deposit,
      date: json['date'] is String ? DateTime.parse(json['date']) : DateTime.now(),
      sumberDana: json['sumberDana'] ?? 'Cash',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'amount': amount,
      'title': title,
      'description': description,
      'type': type == TransactionType.withdrawal ? 'withdrawal' : 'deposit',
      'date': date.toIso8601String(),
      'sumberDana': sumberDana,
    };
  }
}
