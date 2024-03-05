import 'package:flutter/material.dart';
import 'package:nepali_utils/nepali_utils.dart';

void main() {
  NepaliUtils(Language.english); // Set the default language to English
  runApp( DateConverter());
}

class DateConverter extends StatelessWidget {
  const DateConverter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Date Converter',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _items = ['AD to BS', 'BS to AD'];
  String? _selectedItem;
  bool _isAD = true;
  DateTime _dateTime = DateTime.now();
  NepaliDateTime _nepaliDateTime = NepaliDateTime.now();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: const Text('Date Converter'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              value: _selectedItem,
              items: _items
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
                  .toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedItem = value!;
                  if (value == 'AD to BS') {
                    _isAD = true;
                  } else {
                    _isAD = false;
                  }
                });
              },
            ),
            const SizedBox(height: 16.0),
            if (_isAD)
              Text(
                ' Date(AD): \n${NepaliDateFormat('yyyy-MM-dd').format(NepaliDateTime.parse(_dateTime.toString()))}',
                style: const TextStyle(fontSize: 16.0),
              )
            else
              Text(
                ' Date(BS):\n ${NepaliDateFormat('yyyy-MM-dd').format(NepaliDateTime.parse(_nepaliDateTime.toString()))}',
                style: const TextStyle(fontSize: 16.0),
              ),
            const SizedBox(height: 16.0),
            if (_isAD)
              Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: 'Enter AD Date'),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          _dateTime = DateTime.parse(value);
                          _nepaliDateTime = _dateTime.toNepaliDateTime();
                        });
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Text(
                      ' Date(BS):\n ${NepaliDateFormat('yyyy-MM-dd').format(NepaliDateTime.parse(_nepaliDateTime.toString()))}',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  )
                ],
              )
            else
              Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: 'Enter BS Date'),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          _nepaliDateTime = NepaliDateTime.parse(value);
                          _dateTime = _nepaliDateTime.toDateTime();
                        });
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Text(
                      ' Date(AD): \n${NepaliDateFormat('yyyy-MM-dd').format(NepaliDateTime.parse(_dateTime.toString()))}',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
