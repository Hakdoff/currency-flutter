import 'package:exhange_rates_flutter/components/anyToAny.dart';
import 'package:exhange_rates_flutter/components/usdToAny.dart';
import 'package:exhange_rates_flutter/functions/fetchrates.dart';
import 'package:exhange_rates_flutter/models/ratesmodel.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Initial Variables
  late Future<RatesModel> rates;
  late Future<Map> allCurrencies;
  final formkey = GlobalKey<FormState>();

  // Getting RatesModel and All Currencies
  @override
  void initState() {
    super.initState();
    setState(() {
      rates = fetchRates();
      allCurrencies = fetchCurrencies();
    });
  }

  int _selectedIndex = 0;

  Widget _getSelectedWidget(int index, Map currencies, RatesModel rates) {
    switch (index) {
      case 1:
        return UsdToPHP(
          currencies: currencies,
          rates: rates.rates,
        );
      default:
        return AnyToAny(
          currencies: currencies,
          rates: rates.rates,
        );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 38, 35, 35),
      appBar: AppBar(title: Text('Currency Converter'), ),
      body: Container(
        height: h,
        width: w,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: FutureBuilder<RatesModel>(
              future: rates,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                return Center(
                  child: FutureBuilder<Map>(
                    future: allCurrencies,
                    builder: (context, currSnapshot) {
                      if (currSnapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (currSnapshot.hasError) {
                        return Center(child: Text('Error: ${currSnapshot.error}'));
                      }
                      return _getSelectedWidget(
                        _selectedIndex,
                        currSnapshot.data!,
                        snapshot.data!,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 38, 35, 35),
        selectedItemColor: Colors.white, // Selected label and icon color
        unselectedItemColor: Colors.white70,
        items: const <BottomNavigationBarItem>[
        
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_exchange, color: Colors.white,),
            
            label: 'AnyToAny', 
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'USDToAny',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
