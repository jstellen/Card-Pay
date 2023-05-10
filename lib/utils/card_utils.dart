import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardDetails {
  final String cardNumber;
  final String fullName;
  final String cvv;
  final String expiryDate;
  final String issuingCountry;

  CardDetails({
    required this.cardNumber,
    required this.fullName,
    required this.cvv,
    required this.expiryDate,
    required this.issuingCountry,

  });
}

class CardInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    String inputData = newValue.text;
    StringBuffer buffer = StringBuffer();

    for (var i = 0; i < inputData.length; i++) {
      buffer.write(inputData[i]);
      int index = i + 1;

      if (index % 4 == 0 && inputData.length != index) {
        buffer.write("  ");
      }
    }
    return TextEditingValue(
        text: buffer.toString(),
        selection: TextSelection.collapsed(
          offset: buffer.toString().length,
        ));
  }
}
  String getCardType(String cardNumber) {
  if (cardNumber.startsWith('4')) {
    return 'Visa';
  } else if (cardNumber.startsWith('5')) {
    return 'Mastercard';
  } else if (cardNumber.startsWith('3')) {
    // Check for American Express or Discover
    if (cardNumber.length >= 2 && (cardNumber.startsWith('34') || cardNumber.startsWith('37'))) {
      return 'American Express';
    } else if (cardNumber.length >= 3 && cardNumber.startsWith('6011')) {
      return 'Discover';
    }
  }
  return 'Unknown';
}
Widget getCardTypeIcon(String cardType) {
  switch (cardType) {
    case 'Visa':
      return const Image(
        image: AssetImage('/home/jean-jaque/Personal/Rank-Assessement/assets/images/visa.png'),
        width: 10,
        height: 10,
      );
    case 'Mastercard':
      return const Image(
        image: AssetImage('/home/jean-jaque/Personal/Rank-Assessement/assets/images/mastercard.png'),
        width: 10,
        height: 10,      );
    case 'American Express':
      return const Image(
        image: AssetImage('/home/jean-jaque/Personal/Rank-Assessement/assets/images/american_express.png'),
        width: 10,
        height: 10,      );
    case 'Discover':
      return const Image(
        image : AssetImage('/home/jean-jaque/Personal/Rank-Assessement/assets/images/discover.png'),
        width: 10,
        height: 10,      );
    default:
      return const Image(
        image: AssetImage('/home/jean-jaque/Personal/Rank-Assessement/assets/images/visa.png'),
        width: 10,
        height: 10,      );
  }
}

