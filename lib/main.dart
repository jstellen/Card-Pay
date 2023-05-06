import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New Card',
      theme: ThemeData(
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey)
            .copyWith(secondary: Colors.deepOrangeAccent),
      ),
      home: const MyHomePage(title: 'Add New Card'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<CardDetails> cards = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _expirationController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cardTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _cardNumberController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(16),
                      ],
                      decoration: const InputDecoration(
                        hintText: "Card Number",
                        prefixIcon: Icon(Icons.credit_card),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Card Number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        controller: _fullNameController,
                        decoration: const InputDecoration(
                            hintText: "Full Name",
                            prefixIcon: Icon(Icons.person)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter full name';
                          }
                          return null;
                        },
                      ),
                    ),
                    TextFormField(
                      controller: _cardTypeController,
                      decoration: const InputDecoration(
                        hintText: "Card Type",
                        prefixIcon: Icon(Icons.credit_card),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Card Type';
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _cvvController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ],
                            decoration: const InputDecoration(
                              hintText: "CVV",
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter CVV';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _expirationController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                            decoration: const InputDecoration(
                              hintText: "MM/YY",
                              prefixIcon: Icon(Icons.calendar_month),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Date';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _countryController,
                      decoration: const InputDecoration(
                        hintText: "Country",
                        prefixIcon: Icon(Icons.flag),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Country';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              OutlinedButton.icon(
                icon: const Icon(Icons.qr_code_scanner_outlined),
                label: const Text("Scan"),
                onPressed: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final card = CardDetails(
                        cardNumber: _cardNumberController.text,
                        fullName: _fullNameController.text,
                        cvv: _cvvController.text,
                        expiryDate: _expirationController.text,
                        issuingCountry: _countryController.text,
                        cardType: _cardTypeController.text,
                      );
                      setState(() {
                        cards.add(card);
                        _cardNumberController.clear();
                        _fullNameController.clear();
                        _cvvController.clear();
                        _expirationController.clear();
                        _countryController.clear();
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please fill in all fields')),
                      );
                    }
                  },
                  child: const Text("Add Card"),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cards.length,
                  itemBuilder: (BuildContext context, int index) {
                    final card = cards[index];
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.credit_card),
                        title: Text(card.cardNumber),
                        subtitle:
                            Text('${card.fullName} (${card.issuingCountry})'),
                        trailing: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              cards.removeAt(index);
                            });
                          },
                          child: const Text('Delete'),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardDetails {
  final String cardNumber;
  final String fullName;
  final String cvv;
  final String expiryDate;
  final String issuingCountry;
  final String cardType;

  CardDetails({
    required this.cardNumber,
    required this.fullName,
    required this.cvv,
    required this.expiryDate,
    required this.issuingCountry,
    required this.cardType,
  });
}
