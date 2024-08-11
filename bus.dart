import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BusScheduleScreen(),
    );
  }
}

class BusScheduleScreen extends StatefulWidget {
  const BusScheduleScreen({super.key});

  @override
  _BusScheduleScreenState createState() => _BusScheduleScreenState();
}

class _BusScheduleScreenState extends State<BusScheduleScreen> {
  String? source = 'Heaven'; // Default value
  String? destination = 'ANY'; // Default value

  final List<String> sources = [
    'Heaven',
    'Malhar',
    'LHC',
    'Kedar',
    'Yerpedu'
  ];

  final List<String> destinations = [
    'ANY',
    'Heaven',
    'Malhar',
    'LHC',
    'Kedar',
    'Yerpedu'
  ];

  Future<List<dynamic>> fetchBuses() async {
    // This should be replaced with your API endpoint
    final response = await http.get(Uri.parse('https://api.yourbackend.com/buses?source=$source&destination=$destination'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load buses');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ahoy! Take a Seat HitchHiker'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        elevation: 0,
      ),
      body: Container(
        color: Colors.purple[200],
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: source,
                    isExpanded: true,
                    items: sources.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        source = newValue;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButton<String>(
                    value: destination,
                    isExpanded: true,
                    items: destinations.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        destination = newValue;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Fetch buses and display results
                try {
                  List<dynamic> buses = await fetchBuses();
                  // Display the buses or use them as needed
                } catch (error) {
                  // Handle error
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                backgroundColor: Colors.lightBlue, // Button color
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: const Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}
