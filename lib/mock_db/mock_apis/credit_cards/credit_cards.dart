import 'package:pyxl_assignment/models/card/card.dart';

List<Card> getUserCreditCards(String username) {
  return [
    Card(
      cardType: "Physical ebl card",
      cardNo: "****2437****2424",
      expiryDate: DateTime.now(),
      balance: 2960.0,
      image: "assets/card_logo/mastercard.png",
    ),
    Card(
      cardType: "Virtual ebl card",
      cardNo: "****6543****6489",
      expiryDate: DateTime.now(),
      balance: 1280.0,
      image: "assets/card_logo/visa.png",
    ),
    Card(
      cardType: "Ebl ebl card",
      cardNo: "****6282****4829",
      expiryDate: DateTime.now(),
      balance: 6190.0,
      image: "assets/card_logo/amex.png",
    ),
  ];
}
