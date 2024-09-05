import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String _groupFilter = 'All';

  @override
  void initState() {
    super.initState();
    _loadFilters();
  }

  _loadFilters() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _groupFilter = prefs.getString('groupFilter') ?? 'All';
    });
  }

  _saveFilter(String groupFilter) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('groupFilter', groupFilter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: Column(
        children: <String>['All', 'BlackPink','APink', 'G-Friend', 'Twice'].map((String value) {
          return RadioListTile<String>(
            title: Text(value),
            value: value,
            groupValue: _groupFilter,
            onChanged: (String? newValue) {
              setState(() {
                _groupFilter = newValue!;
                _saveFilter(_groupFilter);
                Navigator.pop(context);
              });
            },
          );
        }).toList(),
      ),
    );
  }
}