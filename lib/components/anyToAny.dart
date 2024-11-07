import 'package:exhange_rates_flutter/functions/fetchrates.dart';
import 'package:flutter/material.dart';

class AnyToAny extends StatefulWidget {
  final rates;
  final Map currencies;

  const AnyToAny({Key? key, required this.rates, required this.currencies})
      : super(key: key);

  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<AnyToAny> {
  final usdController = TextEditingController();
  final phpController = TextEditingController();
  String dropdownValue1 = 'USD';
  String dropdownValue2 = 'PHP';
  String answer1 = '';
  String answer2 = '';

  @override
  void initState() {
    super.initState();
    usdController.text = answer1;
    phpController.text = answer2;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      // width: w / 3,
      padding: EdgeInsets.all(20),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Convert Any Currency',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 20),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      TextFormField(
                        key: ValueKey('usd'),
                        controller: usdController,
                        decoration: InputDecoration(hintText: 'Enter Amount'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            answer1 = value;
                            answer2 = convertAny(widget.rates, value,
                                dropdownValue1, dropdownValue2);
                            phpController.text = answer2;
                          });
                        },
                      ),
                      DropdownButton<String>(
                        value: dropdownValue1,
                        icon: const Icon(Icons.arrow_drop_down_rounded),
                        iconSize: 24,
                        elevation: 16,
                        isExpanded: true,
                        underline: Container(
                          height: 2,
                          color: Colors.grey.shade400,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue1 = newValue!;
                            answer2 = convertAny(
                                widget.rates,
                                usdController.text,
                                dropdownValue1,
                                dropdownValue2);
                            phpController.text = answer2;
                          });
                        },
                        items: widget.currencies.keys
                            .toSet()
                            .toList()
                            .map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text('To')),
                Expanded(
                  child: Column(children: [
                    TextFormField(
                      key: ValueKey('php'),
                      controller: phpController,
                      decoration: InputDecoration(hintText: 'Enter Amount'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          answer2 = value;
                          answer1 = convertAny(widget.rates, value,
                              dropdownValue2, dropdownValue1);
                          usdController.text = answer1;
                        });
                      },
                    ),
                    DropdownButton<String>(
                      value: dropdownValue2,
                      icon: const Icon(Icons.arrow_drop_down_rounded),
                      iconSize: 24,
                      elevation: 16,
                      isExpanded: true,
                      underline: Container(
                        height: 2,
                        color: Colors.grey.shade400,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue2 = newValue!;
                          answer2 = convertAny(widget.rates, usdController.text,
                              dropdownValue1, dropdownValue2);
                          phpController.text = answer2;
                        });
                      },
                      items: widget.currencies.keys
                          .toSet()
                          .toList()
                          .map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ]),
                )
              ],
            ),
          ]),
    ));
  }
}
