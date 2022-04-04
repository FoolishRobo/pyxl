class Portfolio {
  String accountType;
  String accountNumber;
  double balance;
  int numberOfCards;

  Portfolio({
    required this.accountType,
    required this.accountNumber,
    required this.balance,
    required this.numberOfCards,
  });

  factory Portfolio.fromMap(Map<dynamic, dynamic> portfolio) {
    return Portfolio(
      accountType: portfolio["accountType"],
      accountNumber: portfolio["accountNumber"],
      balance: portfolio["balance"],
      numberOfCards: portfolio["numberOfCards"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "accountType": accountType,
      "accountNumber": accountNumber,
      "balance": balance,
      "numberOfCards": numberOfCards,
    };
  }

  Portfolio copyWith({
    String? accountType,
    String? accountNumber,
    double? balance,
    int? numberOfCards,
  }) {
    return Portfolio(
      accountType: accountType ?? this.accountType,
      accountNumber: accountNumber ?? this.accountNumber,
      balance: balance ?? this.balance,
      numberOfCards: numberOfCards ?? this.numberOfCards,
    );
  }

  factory Portfolio.initial() {
    return Portfolio(
        accountType: "", accountNumber: "", balance: 0, numberOfCards: 0);
  }
}
