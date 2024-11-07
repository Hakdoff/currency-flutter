import 'package:exhange_rates_flutter/functions/fetchrates.dart';
import 'package:flutter/material.dart';

class UsdToPHP extends StatefulWidget {
  final rates;
  final Map currencies;
  const UsdToPHP({Key? key, @required this.rates, required this.currencies})
      : super(key: key);

  @override
  _UsdToPHPState createState() => _UsdToPHPState();
}

class _UsdToPHPState extends State<UsdToPHP> {
  TextEditingController usdController = TextEditingController();
  String dropdownValue = 'AUD';
  String answer = '';

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'USD to PHP Currency',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                SizedBox(height: 20),
                TextFormField(
                  key: ValueKey('usd'),
                  controller: usdController,
                  decoration: InputDecoration(hintText: 'Enter USD'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        value: dropdownValue,
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
                            dropdownValue = newValue!;
                            setState(() {
                              answer = usdController.text +
                                  ' USD = ' +
                                  convertToUSD(widget.rates, usdController.text,
                                      dropdownValue) +
                                  ' ' +
                                  dropdownValue;
                            });
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
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(child: Text(answer))
              ])),
    );
  }
}
