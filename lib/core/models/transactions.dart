class Transaction {
  final String recipient;
  final double amount;
  final String date;

  Transaction({
    required this.recipient,
    required this.amount,
    required this.date,
  });
  
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      recipient: json['recipient'],
      amount: (json['amount'] as num).toDouble(),
      date: json['date'],
    );
  }
}