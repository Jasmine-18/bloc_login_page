class Transaction {
  final String name;

  Transaction({required this.name});

  static final transaction = [
    Transaction(name: "Transaction 1"),
    Transaction(name: "Transaction 2"),
    Transaction(name: "Transaction 3"),
    Transaction(name: "Transaction 4"),
    Transaction(name: "Transaction 5"),
    Transaction(name: "Transaction 6"),
    Transaction(name: "Transaction 7"),
    Transaction(name: "Transaction 8"),
    Transaction(name: "Transaction 9"),
  ];

  static List<Transaction> getList() {
    return transaction;
  }

  String get getName {
    return name;
  }
}
