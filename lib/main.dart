import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticket App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bine ai venit!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Calatoreste cu noi!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              },
              child: Text("Cauta bilete"),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DateTime _date = DateTime.now();
  int? _numPassengers;
  int _selectedTicketIndex = -1;

  String selectedCity1 = 'Timisoara';
  String selectedCity2 = 'Timisoara';
  List<Ticket> tickets = [    Ticket( price: 20.0),    Ticket( price: 50.0),    Ticket(price: 100.0),  ];
  List<String> cities = [    'Timisoara',    'Resita',    'Oravita',    'Bucuresti',    'Cluj',  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cauta bilete'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'De unde plecati?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
                  DropdownButton<String>(
                    value: selectedCity1,
                    onChanged: (newValue) {
                      setState(() {
                        selectedCity1 = newValue!;
                      });
                    },
                    items: cities.map((city) {
                      return DropdownMenuItem(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
                  ),
              SizedBox(height: 20),
              const Text(
                'Unde doriti sa mergeti?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
                  DropdownButton<String>(
                    value: selectedCity2,
                    onChanged: (newValue) {
                      setState(() {
                        selectedCity2 = newValue!;
                      });
                    },
                    items: cities.map((city) {
                      return DropdownMenuItem(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
                  ),
              SizedBox(height: 20),
              const Text(
                'Cand doriti sa calatoriti?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),
              InkWell(
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  setState(() {
                    _date = pickedDate!;
                  });
                },
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today),
                    const SizedBox(width: 10),
                    Text(
                      _date == null
                          ? 'Selecteaza data'
                          : '${_date.day}/${_date.month}/${_date.year}',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResultsScreen(
                                selectedCity1: selectedCity1,
                                selectedCity2: selectedCity2,
                                date: _date,
                                numPassengers: _numPassengers,
                              )));
                },
                child: Text('Cauta'),
              )
            ])));
  }
}
      class Ticket {

        final double price;
        Ticket({required this.price});
      }

      class ResultsScreen extends StatefulWidget {
        String selectedCity1;
        String selectedCity2;
        DateTime? date;
        int? numPassengers;

        ResultsScreen(
            {
            required DateTime this.date,
            this.numPassengers,
            required this.selectedCity1,
            required this.selectedCity2});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  double _randomPrice = 0.0;
  int? numPassengers;
  @override
  void initState() {
    super.initState();
    _generateRandomPrice();
  }


  double  _generateRandomPrice() {

          const minPrice = 10;
          const maxPrice = 300;
          final randomPrice = math.Random().nextDouble() * (maxPrice - minPrice) + minPrice;
          setState(() {
            _randomPrice = double.parse(randomPrice.toStringAsFixed(2)
            );

          });

          return double.parse(randomPrice.toStringAsFixed(2));

        }

        @override
        Widget build(BuildContext context) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Bine ai venit'),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Text(
                        DateFormat.yMMMMEEEEd().format(widget.date!),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: const Text(
                            'Plecare',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        const SizedBox(
                          width: 200,
                        ),
                        Container(
                          child: const Text(
                            'Destinatie',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(
                                width: 220,
                                child: Container(
                                  height: 25,
                                ));
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(widget.selectedCity1,
                                          style: const TextStyle(fontSize: 23),
                                          semanticsLabel: widget.date.toString()),
                                      SizedBox(width: 180),
                                      Text(widget.selectedCity2,
                                          style: const TextStyle(fontSize: 23),
                                          semanticsLabel: widget.date.toString()),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const Text(
                      'Numarul de calatori',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        numPassengers = int.tryParse(value) ?? 1;
                      },
                    ),
                    SizedBox(height: 190,),
                    Text(
                      'RON: $_randomPrice',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    ElevatedButton(
                      child: Text("Cumpara bilet",  style: Theme.of(context).textTheme.headline3,),
                      onPressed: () {
                        showAlertDialog(context);
                      }),
                  ],

                ),
              ));
        }

          showAlertDialog(BuildContext context) {
            // Create AlertDialog
            AlertDialog alert = AlertDialog(
              title: Text("Drum bun!"),
              actions: [
                  AlertDialog(actions: [
                  Text("Ati cumparat bilet din ${widget.selectedCity1} spre ${widget.selectedCity2}")]),
                ElevatedButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close alert dialog
                  },
                ),
              ],
            );
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );
}

          }
