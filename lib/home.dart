import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_card/utils/card_utils.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ImagePicker picker = ImagePicker();
  File? imageFile;

  String _cardType = '';
  List<CardDetails> cards = [];
  List<String> bannedCountries = ['Iran', 'North Korea', 'Sudan', 'Syria'];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _expirationController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  void _clearControllers() {
    _cardNumberController.clear();
    _fullNameController.clear();
    _cvvController.clear();
    _expirationController.clear();
    _countryController.clear();
  }

  @override
  void initState() {
    super.initState();
  }

  Future _gallery() async {
    final imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile == null) return;

    final temp = File(imageFile.path);
    setState(() => this.imageFile = temp);
  }

  Future _camera() async {
    final imageFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (imageFile == null) return;

    final temp = File(imageFile.path);
    setState(() => this.imageFile = temp);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: theme.primaryColor,
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
                        CardInputFormatter(),
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        hintText: "Card Number",
                        prefixIcon: const Icon(Icons.credit_card),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: getCardTypeIcon(_cardType),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _cardType = getCardType(value);
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Card Number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        controller: _fullNameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            hintText: "Full Name",
                            prefixIcon: const Icon(Icons.person)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter full name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _cvvController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              hintText: "CVV",
                              prefixIcon: const Padding(
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
                              CardMonthInputFormatter()
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              hintText: "MM/YY",
                              prefixIcon: const Icon(Icons.calendar_month),
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
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        hintText: "Country",
                        prefixIcon: const Icon(Icons.flag),
                      ),
                      validator: (value) {

                        String? lowercaseValue = value?.toLowerCase();
                        if (bannedCountries.map((country) => country.toLowerCase()).contains(lowercaseValue)) {
                            return 'Sorry, $value is a banned country.';
                        }
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
                onPressed: () {
                  _camera();
                },
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
                      );
                      // Check if a card with the same card number already exists
                      if (cards.any((existingCard) =>
                          existingCard.cardNumber == card.cardNumber)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('This card already exists.'),
                          ),
                        );
                      } else {
                        setState(() {
                          cards.add(card);
                          _clearControllers();
                        });
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill in all fields'),
                        ),
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
                        title: Text('${card.cardNumber} ($_cardType)'),
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
