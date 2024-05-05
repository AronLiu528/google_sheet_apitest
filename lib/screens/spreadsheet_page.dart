import 'package:flutter/material.dart';

class SpreadsheetPage extends StatelessWidget {
  final List<List<Object>> data;

  SpreadsheetPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spreadsheet Data'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index].join(' - ')),
          );
        },
      ),
    );
  }
}
