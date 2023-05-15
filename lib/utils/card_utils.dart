import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


List<String> bannedCountries = ['Iran', 'North Korea', 'Sudan', 'Syria'];
final List<TextInputFormatter> cardInputFormatters = [
  FilteringTextInputFormatter.digitsOnly,
  LengthLimitingTextInputFormatter(16),
  CardInputFormatter(),
];


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


class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    if (newText.length == 4 && !newText.contains('/')) {
      newText = '${newText.substring(0, 2)}/${newText.substring(2)}';
    } else if (newText.length == 2 && !newText.contains('/')) {
      newText = '${newText.substring(0, 2)}/';
    }

    newText = newText.substring(0, newText.length.clamp(0, 5));

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
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

      if ((i + 1) % 4 == 0 && (i + 1) != inputData.length) {
        buffer.write("  ");
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.toString().length),
    );
  }
}

  String getCardType(String cardNumber) {
  if (cardNumber.startsWith('4')) {
    return 'Visa';
  } else if (cardNumber.startsWith('5')) {
    return 'Mastercard';
  } else if (cardNumber.startsWith('3')) {
    if (cardNumber.length >= 2 && (cardNumber.startsWith('34') || cardNumber.startsWith('37'))) {
      return 'American Express';
    } else if (cardNumber.startsWith('6')) {
      return 'Discover';
    }
  }
  return 'Unknown';
}


Widget getCardTypeIcon(String cardType) {
  switch (cardType) {
    case 'Visa':
      return Image.asset(
        'assets/visa.png',
        width: 20,
        height: 20,
      );
    case 'Mastercard':
      return Image.asset(
        'assets/mastercard.png',
        width: 20,
        height: 20,
      );
    case 'American Express':
      return Image.asset(
        'assets/american_express.png',
        width: 20,
        height: 20,
      );
    case 'Discover':
      return Image.asset(
        'assets/discover.png',
        width: 20,
        height: 20,
      );
    default:
      return Image.asset(
        'assets/visa.png',
        width: 20,
        height: 20,
      );
  }
}

